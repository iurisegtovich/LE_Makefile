# hashtags fazem uma linha inteira virar comentário

#essa linha atribui como esse endereço "/usr/bin/gfortran" como valor da variável FC
FC = /usr/bin/gfortran

#essa linha são opções que eu quero passar ao compilador para gerar um objeto debugável
FCOPTS = ${args} -g -Wall -fcheck-all -cpp -fmax-errors=1 -ffree-line-length-0 #DEBUG

#essa linha são opções para acelerar os cálculos das rotinas de um objeto
#FCOPTS = -g -Wall -cpp -fmax-errors=1 -ffree-line-length-0 #FAST

#aqui eu atribuo endereço de pastas para ficar tudo arrumadinho
OUTPUTDIR = ./obj
SRCDIR = ./src
RUNDIR = ./run

.DEFAULT_GOAL := program.elf
.PHONY: clean

#aqui tem os endereços mais nomes de vários objetos que eu quero gerar
OBJS_output = \
	$(OUTPUTDIR)/mThermodynamicsHandlesSetup.o \
	$(OUTPUTDIR)/mPolyVEoS_Handles.o \
	$(OUTPUTDIR)/mPureMolecularSolids_Handles.o \
	$(OUTPUTDIR)/mHydrates_vdWnP_EL_P0_T0_Handles.o \
	$(OUTPUTDIR)/mAlgorithmsSetup.o \
	$(OUTPUTDIR)/mSimulator.o \
	$(OUTPUTDIR)/mPlotSetup.o

#aqui tem as etiquetas, prérequesitos e instruções para compilar cada objeto
# a logica é etiqueta, dois pontos, prerequesitos
# pula linha, linha de comando

#a minha logica é sempre catar uma rquivo .f90 na pasta src e gerar um arquivo .o na pasta obj
#a opção -J serve pra deixar os .mod arrumadinhos junto com os .o na pasta obj
#os $(variavel) expandem a variavel, ou seja, puxam o valor q estiver armazenado nela e jogam na linha de comando
#o arroba lá no final passa para a linha de comando o nome da etiqueta, assim o -o faz gerar um arquivo com o nome q tá na etiqueta
# o -c quer dizer q o .f90 vai virar .o mas não vai virar executável .elf(.out, .exe. etc...) ainda
$(OUTPUTDIR)/mPolyVEoS_Handles.o: $(SRCDIR)/mPolyVEoS_Handles.f90
	$(FC) $(FCOPTS) -J$(OUTPUTDIR) -c $(SRCDIR)/mPolyVEoS_Handles/mPolyVEoS_Handles.f90 -o $@

$(OUTPUTDIR)/mPureMolecularSolids_Handles.o: $(SRCDIR)/mPureMolecularSolids_Handles.f90 $(OUTPUTDIR)/mPolyVEoS_Handles.o 
	$(FC) $(FCOPTS) -J$(OUTPUTDIR) -c $(SRCDIR)/mPureMolecularSolids_Handles/mPureMolecularSolids_Handles.f90 -o $@

$(OUTPUTDIR)/mHydrates_vdWnP_EL_P0_T0_Handles.o: $(SRCDIR)/mHydrates_vdWnP_EL_P0_T0_Handles.f90 $(OUTPUTDIR)/mPureMolecularSolids_Handles.o $(OUTPUTDIR)/mPolyVEoS_Handles.o 
	$(FC) $(FCOPTS) -J$(OUTPUTDIR) -c $(SRCDIR)/mHydrates_vdWnP_EL_P0_T0_Handles/mHydrates_vdWnP_EL_P0_T0_Handles.f90 -o $@

$(OUTPUTDIR)/mThermodynamicsHandlesSetup.o: $(SRCDIR)/mThermodynamicsHandlesSetup.f90 $(OUTPUTDIR)/mHydrates_vdWnP_EL_P0_T0_Handles.o $(OUTPUTDIR)/mPolyVEoS_Handles.o $(OUTPUTDIR)/mPureMolecularSolids_Handles.o 
	$(FC) $(FCOPTS) -J$(OUTPUTDIR) -c $(SRCDIR)/mThermodynamicsHandlesSetup/mThermodynamicsHandlesSetup.f90 -o $@

$(OUTPUTDIR)/mAlgorithmsSetup.o: $(SRCDIR)/mAlgorithmsSetup.f90 $(OUTPUTDIR)/mThermodynamicsHandlesSetup.o 
	$(FC) $(FCOPTS) -J$(OUTPUTDIR) -c $(SRCDIR)/mAlgorithmsSetup/mAlgorithmsSetup.f90 -o $@

$(OUTPUTDIR)/mSimulator.o: $(SRCDIR)/mSimulator.f90 $(OUTPUTDIR)/mThermodynamicsHandlesSetup.o $(OUTPUTDIR)/mAlgorithmsSetup.o $(OUTPUTDIR)/mPlotSetup.o 
	$(FC) $(FCOPTS) -J$(OUTPUTDIR) -c $(SRCDIR)/mSimulator/mSimulator.f90 -o $@

$(OUTPUTDIR)/mPlotSetup.o: $(SRCDIR)/mPlotSetup.f90 $(OUTPUTDIR)/mThermodynamicsHandlesSetup.o $(OUTPUTDIR)/mAlgorithmsSetup.o 
	$(FC) $(FCOPTS) -J$(OUTPUTDIR) -c $(SRCDIR)/mPlotSetup/mPlotSetup.f90 -o $@

#essa clean só roda se você digitar "make clean"
#se fizer isso ela roda e deleta os intermediarios .o, .mod, .a, .elf
	rm -f $(OUTPUTDIR)/*.o 
	rm -f $(OUTPUTDIR)/*.mod
	rm -f $(OUTPUTDIR)/*.a
	rm -f $(RUNDIR)/*program.elf

#aqui é pra compilar o principal que ficou faltando, tipo para os o poderem ser bibliotecas q funcionam com varias opções de programa principal a se escolher
$(OUTPUTDIR)/program.o: $(SRCDIR)/program/program.f90
	$(FC) $(FCOPTS) -J$(OUTPUTDIR) -c $(SRCDIR)/program/program.f90 -o $@

 #aqui é finalmente linkar tudo para geerar o executável
 #se tiver biblioteca externa a hora de colocar elas é agora, na linkagem
$(RUNDIR)/program.elf: $(OUTPUTDIR)/program.o
	$(FC) $(FCOPTS) -J$(OUTPUTDIR) $(OUTPUTDIR)/program.o -o $@

#essa aqui roda se você escrever "make roda"
#é tipo aquele botão build+run do visual studio e etc
roda: $(RUNDIR)/program.elf
	$(RUNDIR)/program.elf 2>&1 | tee $(RUNDIR)/program.log


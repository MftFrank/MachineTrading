/*
 * MATLAB Compiler: 4.11 (R2009b)
 * Date: Tue Aug 17 16:18:54 2010
 * Arguments: "-B" "macro_default" "-m" "-W" "main" "-T" "link:exe" "runCSV.m" 
 */

#include "mclmcrrt.h"

#ifdef __cplusplus
extern "C" {
#endif
const unsigned char __MCC_runCSV_session_key[] = {
    '5', 'C', 'B', '2', 'F', '0', 'F', '1', 'B', '7', '9', 'B', '6', 'B', '8',
    '3', '9', 'D', 'D', '9', 'B', 'C', 'F', '1', '6', '8', 'F', 'A', 'F', 'A',
    '5', 'A', 'D', 'D', 'D', '2', 'E', 'F', 'F', 'B', 'A', 'C', 'B', 'A', '4',
    '6', 'C', 'D', 'B', '1', '4', '1', '8', '9', '2', 'B', '7', 'E', '8', '0',
    '5', '4', '8', 'E', '1', '0', '3', '4', '8', '7', '4', '8', 'E', '6', 'C',
    '0', 'F', 'B', 'E', 'E', '9', 'F', 'D', 'B', '3', '9', 'C', '7', '9', 'A',
    '4', 'E', '5', 'E', 'A', 'D', 'A', 'C', 'A', 'F', 'F', 'A', '2', '0', 'D',
    'E', '3', '7', '4', 'C', 'C', '9', '2', 'A', 'A', '8', '9', 'A', '0', '1',
    '5', '5', 'D', '3', '7', '7', '8', '0', '8', '1', '0', '0', '3', 'F', '8',
    '5', 'F', 'F', '8', '6', '4', 'D', '7', 'A', '0', '9', 'A', '2', '8', '9',
    'C', '5', '4', '2', '3', '0', '6', '3', '1', 'F', '9', '3', '2', 'E', 'E',
    'C', '1', '0', '6', '3', '4', '2', 'C', '8', 'B', 'A', '7', 'B', 'C', '7',
    'C', 'E', '6', '2', 'E', '1', 'E', '1', 'F', 'A', '0', 'E', '1', '3', 'E',
    'A', 'E', '6', '7', '1', '1', '2', '9', 'A', '6', 'B', '2', 'E', '0', '1',
    '3', '8', '3', '4', '2', '2', '4', 'F', '4', '5', '3', '5', '2', 'C', 'B',
    'D', '7', '3', '3', 'F', 'D', 'A', 'F', 'F', 'D', 'D', 'F', '7', '5', '6',
    '8', 'B', 'C', '4', '3', '6', '9', '9', '8', 'E', 'E', '6', 'E', 'E', '5',
    '6', '\0'};

const unsigned char __MCC_runCSV_public_key[] = {
    '3', '0', '8', '1', '9', 'D', '3', '0', '0', 'D', '0', '6', '0', '9', '2',
    'A', '8', '6', '4', '8', '8', '6', 'F', '7', '0', 'D', '0', '1', '0', '1',
    '0', '1', '0', '5', '0', '0', '0', '3', '8', '1', '8', 'B', '0', '0', '3',
    '0', '8', '1', '8', '7', '0', '2', '8', '1', '8', '1', '0', '0', 'C', '4',
    '9', 'C', 'A', 'C', '3', '4', 'E', 'D', '1', '3', 'A', '5', '2', '0', '6',
    '5', '8', 'F', '6', 'F', '8', 'E', '0', '1', '3', '8', 'C', '4', '3', '1',
    '5', 'B', '4', '3', '1', '5', '2', '7', '7', 'E', 'D', '3', 'F', '7', 'D',
    'A', 'E', '5', '3', '0', '9', '9', 'D', 'B', '0', '8', 'E', 'E', '5', '8',
    '9', 'F', '8', '0', '4', 'D', '4', 'B', '9', '8', '1', '3', '2', '6', 'A',
    '5', '2', 'C', 'C', 'E', '4', '3', '8', '2', 'E', '9', 'F', '2', 'B', '4',
    'D', '0', '8', '5', 'E', 'B', '9', '5', '0', 'C', '7', 'A', 'B', '1', '2',
    'E', 'D', 'E', '2', 'D', '4', '1', '2', '9', '7', '8', '2', '0', 'E', '6',
    '3', '7', '7', 'A', '5', 'F', 'E', 'B', '5', '6', '8', '9', 'D', '4', 'E',
    '6', '0', '3', '2', 'F', '6', '0', 'C', '4', '3', '0', '7', '4', 'A', '0',
    '4', 'C', '2', '6', 'A', 'B', '7', '2', 'F', '5', '4', 'B', '5', '1', 'B',
    'B', '4', '6', '0', '5', '7', '8', '7', '8', '5', 'B', '1', '9', '9', '0',
    '1', '4', '3', '1', '4', 'A', '6', '5', 'F', '0', '9', '0', 'B', '6', '1',
    'F', 'C', '2', '0', '1', '6', '9', '4', '5', '3', 'B', '5', '8', 'F', 'C',
    '8', 'B', 'A', '4', '3', 'E', '6', '7', '7', '6', 'E', 'B', '7', 'E', 'C',
    'D', '3', '1', '7', '8', 'B', '5', '6', 'A', 'B', '0', 'F', 'A', '0', '6',
    'D', 'D', '6', '4', '9', '6', '7', 'C', 'B', '1', '4', '9', 'E', '5', '0',
    '2', '0', '1', '1', '1', '\0'};

static const char * MCC_runCSV_matlabpath_data[] = 
  { "runCSV/", "$TOOLBOXDEPLOYDIR/",
    "$TOOLBOXMATLABDIR/general/", "$TOOLBOXMATLABDIR/ops/",
    "$TOOLBOXMATLABDIR/lang/", "$TOOLBOXMATLABDIR/elmat/",
    "$TOOLBOXMATLABDIR/randfun/", "$TOOLBOXMATLABDIR/elfun/",
    "$TOOLBOXMATLABDIR/specfun/", "$TOOLBOXMATLABDIR/matfun/",
    "$TOOLBOXMATLABDIR/datafun/", "$TOOLBOXMATLABDIR/polyfun/",
    "$TOOLBOXMATLABDIR/funfun/", "$TOOLBOXMATLABDIR/sparfun/",
    "$TOOLBOXMATLABDIR/scribe/", "$TOOLBOXMATLABDIR/graph2d/",
    "$TOOLBOXMATLABDIR/graph3d/", "$TOOLBOXMATLABDIR/specgraph/",
    "$TOOLBOXMATLABDIR/graphics/", "$TOOLBOXMATLABDIR/uitools/",
    "$TOOLBOXMATLABDIR/strfun/", "$TOOLBOXMATLABDIR/imagesci/",
    "$TOOLBOXMATLABDIR/iofun/", "$TOOLBOXMATLABDIR/audiovideo/",
    "$TOOLBOXMATLABDIR/timefun/", "$TOOLBOXMATLABDIR/datatypes/",
    "$TOOLBOXMATLABDIR/verctrl/", "$TOOLBOXMATLABDIR/codetools/",
    "$TOOLBOXMATLABDIR/helptools/", "$TOOLBOXMATLABDIR/demos/",
    "$TOOLBOXMATLABDIR/timeseries/", "$TOOLBOXMATLABDIR/hds/",
    "$TOOLBOXMATLABDIR/guide/", "$TOOLBOXMATLABDIR/plottools/",
    "toolbox/local/", "toolbox/shared/dastudio/",
    "$TOOLBOXMATLABDIR/datamanager/", "toolbox/compiler/" };

static const char * MCC_runCSV_classpath_data[] = 
  { "" };

static const char * MCC_runCSV_libpath_data[] = 
  { "" };

static const char * MCC_runCSV_app_opts_data[] = 
  { "" };

static const char * MCC_runCSV_run_opts_data[] = 
  { "" };

static const char * MCC_runCSV_warning_state_data[] = 
  { "off:MATLAB:dispatcher:nameConflict" };


mclComponentData __MCC_runCSV_component_data = { 

  /* Public key data */
  __MCC_runCSV_public_key,

  /* Component name */
  "runCSV",

  /* Component Root */
  "",

  /* Application key data */
  __MCC_runCSV_session_key,

  /* Component's MATLAB Path */
  MCC_runCSV_matlabpath_data,

  /* Number of directories in the MATLAB Path */
  38,

  /* Component's Java class path */
  MCC_runCSV_classpath_data,
  /* Number of directories in the Java class path */
  0,

  /* Component's load library path (for extra shared libraries) */
  MCC_runCSV_libpath_data,
  /* Number of directories in the load library path */
  0,

  /* MCR instance-specific runtime options */
  MCC_runCSV_app_opts_data,
  /* Number of MCR instance-specific runtime options */
  0,

  /* MCR global runtime options */
  MCC_runCSV_run_opts_data,
  /* Number of MCR global runtime options */
  0,
  
  /* Component preferences directory */
  "runCSV_3E12CED6BD984D8C79A24F23B326034C",

  /* MCR warning status data */
  MCC_runCSV_warning_state_data,
  /* Number of MCR warning status modifiers */
  1,

  /* Path to component - evaluated at runtime */
  NULL

};

#ifdef __cplusplus
}
#endif



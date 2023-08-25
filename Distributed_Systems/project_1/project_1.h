/*
 * Please do not edit this file.
 * It was generated using rpcgen.
 */

#ifndef _PROJECT_1_H_RPCGEN
#define _PROJECT_1_H_RPCGEN

#include <rpc/rpc.h>


#ifdef __cplusplus
extern "C" {
#endif


struct arrays {
	struct {
		u_int x_len;
		int *x_val;
	} x;
	struct {
		u_int y_len;
		int *y_val;
	} y;
};
typedef struct arrays arrays;

struct arrays_float {
	struct {
		u_int x_len;
		int *x_val;
	} x;
	struct {
		u_int y_len;
		int *y_val;
	} y;
	float r;
};
typedef struct arrays_float arrays_float;

struct output_2 {
	float out[2];
};
typedef struct output_2 output_2;

struct output_n {
	struct {
		u_int out_len;
		float *out_val;
	} out;
};
typedef struct output_n output_n;

#define FIND_INNER_PRODUCT 0x00000001
#define IP_VERS 1

#if defined(__STDC__) || defined(__cplusplus)
#define IP 1
extern  int * ip_1(arrays *, CLIENT *);
extern  int * ip_1_svc(arrays *, struct svc_req *);
extern int find_inner_product_1_freeresult (SVCXPRT *, xdrproc_t, caddr_t);

#else /* K&R C */
#define IP 1
extern  int * ip_1();
extern  int * ip_1_svc();
extern int find_inner_product_1_freeresult ();
#endif /* K&R C */

#define FIND_AVERAGE 0x00000002
#define A_VERS 1

#if defined(__STDC__) || defined(__cplusplus)
#define A 1
extern  output_2 * a_1(arrays *, CLIENT *);
extern  output_2 * a_1_svc(arrays *, struct svc_req *);
extern int find_average_1_freeresult (SVCXPRT *, xdrproc_t, caddr_t);

#else /* K&R C */
#define A 1
extern  output_2 * a_1();
extern  output_2 * a_1_svc();
extern int find_average_1_freeresult ();
#endif /* K&R C */

#define FIND_PRODUCT 0x00000003
#define P_VERS 1

#if defined(__STDC__) || defined(__cplusplus)
#define P 1
extern  output_n * p_1(arrays_float *, CLIENT *);
extern  output_n * p_1_svc(arrays_float *, struct svc_req *);
extern int find_product_1_freeresult (SVCXPRT *, xdrproc_t, caddr_t);

#else /* K&R C */
#define P 1
extern  output_n * p_1();
extern  output_n * p_1_svc();
extern int find_product_1_freeresult ();
#endif /* K&R C */

/* the xdr functions */

#if defined(__STDC__) || defined(__cplusplus)
extern  bool_t xdr_arrays (XDR *, arrays*);
extern  bool_t xdr_arrays_float (XDR *, arrays_float*);
extern  bool_t xdr_output_2 (XDR *, output_2*);
extern  bool_t xdr_output_n (XDR *, output_n*);

#else /* K&R C */
extern bool_t xdr_arrays ();
extern bool_t xdr_arrays_float ();
extern bool_t xdr_output_2 ();
extern bool_t xdr_output_n ();

#endif /* K&R C */

#ifdef __cplusplus
}
#endif

#endif /* !_PROJECT_1_H_RPCGEN */

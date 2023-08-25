/*
 * Please do not edit this file.
 * It was generated using rpcgen.
 */

#include "project_1.h"
#include <stdio.h>
#include <stdlib.h>
#include <rpc/pmap_clnt.h>
#include <string.h>
#include <memory.h>
#include <sys/socket.h>
#include <netinet/in.h>

#ifndef SIG_PF
#define SIG_PF void(*)(int)
#endif

static void
find_inner_product_1(struct svc_req *rqstp, register SVCXPRT *transp)
{
	union {
		arrays ip_1_arg;
	} argument;
	char *result;
	xdrproc_t _xdr_argument, _xdr_result;
	char *(*local)(char *, struct svc_req *);

	switch (rqstp->rq_proc) {
	case NULLPROC:
		(void) svc_sendreply (transp, (xdrproc_t) xdr_void, (char *)NULL);
		return;

	case IP:
		_xdr_argument = (xdrproc_t) xdr_arrays;
		_xdr_result = (xdrproc_t) xdr_int;
		local = (char *(*)(char *, struct svc_req *)) ip_1_svc;
		break;

	default:
		svcerr_noproc (transp);
		return;
	}
	memset ((char *)&argument, 0, sizeof (argument));
	if (!svc_getargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		svcerr_decode (transp);
		return;
	}
	result = (*local)((char *)&argument, rqstp);
	if (result != NULL && !svc_sendreply(transp, (xdrproc_t) _xdr_result, result)) {
		svcerr_systemerr (transp);
	}
	if (!svc_freeargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		fprintf (stderr, "%s", "unable to free arguments");
		exit (1);
	}
	return;
}

static void
find_average_1(struct svc_req *rqstp, register SVCXPRT *transp)
{
	union {
		arrays a_1_arg;
	} argument;
	char *result;
	xdrproc_t _xdr_argument, _xdr_result;
	char *(*local)(char *, struct svc_req *);

	switch (rqstp->rq_proc) {
	case NULLPROC:
		(void) svc_sendreply (transp, (xdrproc_t) xdr_void, (char *)NULL);
		return;

	case A:
		_xdr_argument = (xdrproc_t) xdr_arrays;
		_xdr_result = (xdrproc_t) xdr_output_2;
		local = (char *(*)(char *, struct svc_req *)) a_1_svc;
		break;

	default:
		svcerr_noproc (transp);
		return;
	}
	memset ((char *)&argument, 0, sizeof (argument));
	if (!svc_getargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		svcerr_decode (transp);
		return;
	}
	result = (*local)((char *)&argument, rqstp);
	if (result != NULL && !svc_sendreply(transp, (xdrproc_t) _xdr_result, result)) {
		svcerr_systemerr (transp);
	}
	if (!svc_freeargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		fprintf (stderr, "%s", "unable to free arguments");
		exit (1);
	}
	return;
}

static void
find_product_1(struct svc_req *rqstp, register SVCXPRT *transp)
{
	union {
		arrays_float p_1_arg;
	} argument;
	char *result;
	xdrproc_t _xdr_argument, _xdr_result;
	char *(*local)(char *, struct svc_req *);

	switch (rqstp->rq_proc) {
	case NULLPROC:
		(void) svc_sendreply (transp, (xdrproc_t) xdr_void, (char *)NULL);
		return;

	case P:
		_xdr_argument = (xdrproc_t) xdr_arrays_float;
		_xdr_result = (xdrproc_t) xdr_output_n;
		local = (char *(*)(char *, struct svc_req *)) p_1_svc;
		break;

	default:
		svcerr_noproc (transp);
		return;
	}
	memset ((char *)&argument, 0, sizeof (argument));
	if (!svc_getargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		svcerr_decode (transp);
		return;
	}
	result = (*local)((char *)&argument, rqstp);
	if (result != NULL && !svc_sendreply(transp, (xdrproc_t) _xdr_result, result)) {
		svcerr_systemerr (transp);
	}
	if (!svc_freeargs (transp, (xdrproc_t) _xdr_argument, (caddr_t) &argument)) {
		fprintf (stderr, "%s", "unable to free arguments");
		exit (1);
	}
	return;
}

int
main (int argc, char **argv)
{
	register SVCXPRT *transp;

	pmap_unset (FIND_INNER_PRODUCT, IP_VERS);
	pmap_unset (FIND_AVERAGE, A_VERS);
	pmap_unset (FIND_PRODUCT, P_VERS);

	transp = svcudp_create(RPC_ANYSOCK);
	if (transp == NULL) {
		fprintf (stderr, "%s", "cannot create udp service.");
		exit(1);
	}
	if (!svc_register(transp, FIND_INNER_PRODUCT, IP_VERS, find_inner_product_1, IPPROTO_UDP)) {
		fprintf (stderr, "%s", "unable to register (FIND_INNER_PRODUCT, IP_VERS, udp).");
		exit(1);
	}
	if (!svc_register(transp, FIND_AVERAGE, A_VERS, find_average_1, IPPROTO_UDP)) {
		fprintf (stderr, "%s", "unable to register (FIND_AVERAGE, A_VERS, udp).");
		exit(1);
	}
	if (!svc_register(transp, FIND_PRODUCT, P_VERS, find_product_1, IPPROTO_UDP)) {
		fprintf (stderr, "%s", "unable to register (FIND_PRODUCT, P_VERS, udp).");
		exit(1);
	}

	transp = svctcp_create(RPC_ANYSOCK, 0, 0);
	if (transp == NULL) {
		fprintf (stderr, "%s", "cannot create tcp service.");
		exit(1);
	}
	if (!svc_register(transp, FIND_INNER_PRODUCT, IP_VERS, find_inner_product_1, IPPROTO_TCP)) {
		fprintf (stderr, "%s", "unable to register (FIND_INNER_PRODUCT, IP_VERS, tcp).");
		exit(1);
	}
	if (!svc_register(transp, FIND_AVERAGE, A_VERS, find_average_1, IPPROTO_TCP)) {
		fprintf (stderr, "%s", "unable to register (FIND_AVERAGE, A_VERS, tcp).");
		exit(1);
	}
	if (!svc_register(transp, FIND_PRODUCT, P_VERS, find_product_1, IPPROTO_TCP)) {
		fprintf (stderr, "%s", "unable to register (FIND_PRODUCT, P_VERS, tcp).");
		exit(1);
	}

	svc_run ();
	fprintf (stderr, "%s", "svc_run returned");
	exit (1);
	/* NOTREACHED */
}

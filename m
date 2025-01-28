Return-Path: <linux-pwm+bounces-4750-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E74AA2086F
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jan 2025 11:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D06C3A370D
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jan 2025 10:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CC819CC39;
	Tue, 28 Jan 2025 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xrvBs7Gr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E881917D8;
	Tue, 28 Jan 2025 10:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738059896; cv=fail; b=e6diGvZY0fxCCTkJmiaiFyy85s+Q8PnNSrbn0OJFUomciorgP8RrJ6LQFrSwExw3bg/XRg4iq0Znrh4X/IoU0MUhI+ku6jKfBBU/n5+wRcnfXLsz2liUnU4jGEgtSUW9Bg3N4IE8cJ+YRI5v583nxqYhKUZ1uwJqob+FYqy//Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738059896; c=relaxed/simple;
	bh=HMTSftcf3bBpWzr9MEnH6h5jm20rCM3gpUvFc7PpdYE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FfyjUqKTmgLzDa/VbHQx3JxlF4pDeR/eg0IDuNbO/7+dPxh6BiTQAx9Ur1LGW/4RSWAZrLLTLBbnvWIdmIAMbPEgz88KfswmVRbyr97j90gK81oO+0c5An6+UrZSvLkSJTJ42j8z4RPVDpNFAML2h+GTurWOWS8W+LJD77WhYy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xrvBs7Gr; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SALu7W003892;
	Tue, 28 Jan 2025 05:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VZP4U
	2xDtms24HOxFccBN2JmpPNRl40uVnpKLkjgSfI=; b=xrvBs7Gr4nDMuRq19VqCb
	8DSAi5C6XkLLoMrb3bv6ap95Bv5VmA+7NRdAsCwxXihczKi/gtaOzLPnHw+AT+98
	e5z+W4pfIF3ABT0ydIEkO8HmvtajOl3kA+W28KsBVNcQvbFIn824uylwCIPldAju
	RAd/XynfHn7aVILdRlXqe13fB4QtZkU22yiXpF5eHiEGRHXC1s2ZcpEJYHqcVtis
	4l/1ejpYMNHDsiSpCH4hw3yOCe9ll1bWWnpzcvmP92RbUuVWuFVn9EObiEJ3ysuA
	EtYHoCrEcMdZTMzghzEcdA7fQuVidZRONLj9ABzk0MMgd6+wFwRsCwyF+WlaJGVB
	w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012013.outbound.protection.outlook.com [40.93.14.13])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44ewdtg0a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 05:24:40 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOlXcwBCEwCTZIN36GT6kdfEpqkf45+AsJyahrsyQKmKieeTa2rJYpeg/febLgpvdZSWJULEuOtiKQoFWuQ5KtzLtoeFjW63o8twxLZPkC/MXDB9k1htGKDAgnATjDtdSlXsbw2oAxm6nYGP7S0WeUlnn/if5eT/Ss3SuM73lk4EpTIcV5o4dErHm6Sh/8HdCSuH/v4QDJNO9d2pmGm9qlzaqM8OklmUK7vCqQatTVcVqK4/3sTqhIra8sOyUV/5tqAjeq/indRP5tTMHV4/Alv8xLMwnv+ZwMw3Qec/oUxHOOj4HEplhMxyxCls8cTh5SXOncJFrL0fTvdrsy1Y2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZP4U2xDtms24HOxFccBN2JmpPNRl40uVnpKLkjgSfI=;
 b=juAKFD3Ag0MmWzQvnpmfE7z+n/7tvjkBjar1+ks61UF6WRgncuaM+owgD/1IvQvt2swZTfqtnmAWniv0mjy/3liT6dyAVHNf2B4WzhE/jIn/Jcti3s5CmY41kroVNU1t5GlCLMy8+YHooQWnjwRhxyzLhJYSwQvlsIlpdi4IEhpt7sE029obiB030nXX5+9XEpmGqKuEdB+AgREq+3KL89I8jWnBoO5HkVyVw3lRjhM5PcWUdpYtm0mfMtCPSUeGRUo+AXWw/XtcdFthi8WKoKLB6QywAKN0jynnM/ie6tXZkYAx/xN5Fbkq6wfD4+/q5rC2aEFF2H5jydz5uK1MAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by SJ0PR03MB7152.namprd03.prod.outlook.com (2603:10b6:a03:4d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Tue, 28 Jan
 2025 10:24:37 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%4]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 10:24:37 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Conor Dooley <conor@kernel.org>
CC: "jic23@kernel.org" <jic23@kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: [PATCH v6 1/3] dt-bindings: iio: adf4371: add refin mode
Thread-Topic: [PATCH v6 1/3] dt-bindings: iio: adf4371: add refin mode
Thread-Index: AQHbcKO5YLhIBhkLEUCfXKb5pLLx2bMq54YAgAEUmGA=
Date: Tue, 28 Jan 2025 10:24:37 +0000
Message-ID:
 <CY4PR03MB3399981C39318501A2FEE87A9BEF2@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20250127101026.5320-1-antoniu.miclaus@analog.com>
 <20250127101026.5320-2-antoniu.miclaus@analog.com>
 <20250127-makeshift-legroom-bb02764c6ed6@spud>
In-Reply-To: <20250127-makeshift-legroom-bb02764c6ed6@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdXNc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0xMTIyZGZjOC1kZDYyLTExZWYtYjAxZi0xNGFi?=
 =?us-ascii?Q?YzVmM2QzMjVcYW1lLXRlc3RcMTEyMmRmY2EtZGQ2Mi0xMWVmLWIwMWYtMTRh?=
 =?us-ascii?Q?YmM1ZjNkMzI1Ym9keS50eHQiIHN6PSIxNDk3IiB0PSIxMzM4MjUzMzQ3NDYw?=
 =?us-ascii?Q?OTIxNjAiIGg9Imx3eXBWa1BLOVJDajN1eWdDM056L3VQcGh6RT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?Q0FFbjNUYm5IYkFWN25vclJLa1Y4Nlh1ZWl0RXFSWHpvREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBVEFZNU53QUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|SJ0PR03MB7152:EE_
x-ms-office365-filtering-correlation-id: 3bb13315-4816-4340-6f35-08dd3f85f7a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?L3ZNp4WWEGhvNAmIO6t7s6qy/mMWpiM73mSgoIX+4QPv5LEb1eXeX+ToJK3j?=
 =?us-ascii?Q?GX4PS9v1vbIMdkt4iAvxhdCtg5hoqzk5QfLNZhRX0tH+9g7sj8wfMa7rph0G?=
 =?us-ascii?Q?ni+c5NXoshfC2TfircbenXYMt2TJsKjxBQoWemjedl15d4rsC7GPs74T9FKu?=
 =?us-ascii?Q?rgnSXgjF43QJQOPtVVmhQb+5HvRld8qaaetqTHe+Fx9A1DQUL1Qp8rjxh5Rb?=
 =?us-ascii?Q?sGFNkotke663zSnJGR6O6tk8enixvNRLj16+Lh+8k4aZYB3lc2isdpMozU0p?=
 =?us-ascii?Q?xeEp+wseybZSdh5vNJoELE3gWnCGpQJDI5VzmXT5LndIi3Smz/dfT7A29cAu?=
 =?us-ascii?Q?stG96pe6p9qZ0WTcFnFXwubXJc80GkiavD+ANJOkdkKS+R2kn+r3+Cdgf0YS?=
 =?us-ascii?Q?sGLM688s2VhTlFBMoMpvYmFcu9QCdxxqtX/pSyI5RxwQTxOYUI83eVJfvrih?=
 =?us-ascii?Q?o/vcT0hvxOiTij22OstmIbkNfyIwwY56FpntGj4iPmNrC4Hnm6VNGvrzZKSQ?=
 =?us-ascii?Q?FMn1veLXyp+gstqYwH+Kw3zjZEqnsIju4KAfsYmmIsOAQRMc0DRL4hS2pFgj?=
 =?us-ascii?Q?lUMVzet9gGH1GOYA9MBo7GOXPhLuXMeGWEsoHGZ0u0+/M0ZuEtC7zkc4ikvF?=
 =?us-ascii?Q?qnkNN69SdRt4zQl5Am7vixNEA+R6gf7wHJO6LHJrdlJh//N0n1xmnA3T3xZ8?=
 =?us-ascii?Q?DQTYFAVrQ5I9xtBAc6S+evHizXfmlGh9c8QPb0W9YWvEjJO8DpihlhsKZsBn?=
 =?us-ascii?Q?EXxGzu0KGkdSFgolbDiVn/6tGmXvOol3MlR0BlNIlswtkbsSU3ToEtIZU40z?=
 =?us-ascii?Q?/JSwE/1HBLkHqJqGkCIirKF1gcPe0uE+zTwDEAXVjuBZ27dGVTYmMfCQoSku?=
 =?us-ascii?Q?+vVTHJYH+scC2z/ya/QTwyjKHd0+2DsujZ6SwpXfOmhJ8lL8Mwl1WTXzWRGC?=
 =?us-ascii?Q?7KokR18gIK08PdSoL/9C1yyR5WLRjv7cXAc/VModZ6Tfsz/nQysPw9GpWrUu?=
 =?us-ascii?Q?hug8/z4H8vXHRPADYrIgBWT24AjW2TdIxgTiY18YeVXZaEfsg0A0eAi/4b+i?=
 =?us-ascii?Q?gWhU/HY+DB7BQ5k+XKzD4vBCyrAqw/wJ2sQymd080HxR/TV7BJ+a9OhruuTn?=
 =?us-ascii?Q?InUP3FLb94eFPrwAmfUgPHT5pq1fkOnDILCgNIpGkgeLQzHqE1cwpp6wC5BR?=
 =?us-ascii?Q?D880dxN/dK3iYshxA/kZr0MFbx6C1k1AcJcZhRJEjBJuVhfN1lLrj4eU8WKK?=
 =?us-ascii?Q?XLAn54kF8xQNzrX04JYjK0N9zB2ytffAlfqKSEL1QUmUTx/hdL6EnuX04Dtd?=
 =?us-ascii?Q?nkVpBRpXI6tlt6psHDjr0roVPYN6XUbx7uan9Cy3ibw5xXGMQ8zI/uwL3cNC?=
 =?us-ascii?Q?kkGu8hbEbqjUm0D4lO6Ia8c4RVOPCm7XK/sQhqD/e4EKzrWhOF8wNpnv26Xl?=
 =?us-ascii?Q?G4Qz1R8byyltO7h7uIES6kTkouLCg4BF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+Aq6dw1N0yolpgsgOJUL6SiRIK8QtZMYpBl3qLamU+MlTM+qoYklxHxtPfuX?=
 =?us-ascii?Q?ZimLAF67FLlMWt1z9OnclEkUAsTEZuY9OY9xbiN+CmZECuiFli2lDh673COm?=
 =?us-ascii?Q?RbckpulgTFFaAnMdf0DFz620GRzYuzqnJ+eU7Tqw/lLF2HYj2YAOTYF2IzgH?=
 =?us-ascii?Q?u6ln6DNGuFMncDjWigRlDclzTyJQ/g6T71Bv0ktZPCfki+e9Se4ltdzM7gdk?=
 =?us-ascii?Q?qMabM9IrhSzo8A97nl++T+KuK//v0SLOXMedEpayqYqdOW4+6MkDrRQnZLQB?=
 =?us-ascii?Q?KmXur8JjVKFCJECsSVal0cPkNP75RqBRKQNtikMy1XoW7XSD8P8SOQ4UPr4E?=
 =?us-ascii?Q?dM01STiCu/JakeMR35dZoNMKH9prgpcM/4+LATzSfEHCmcwLxC7MzsRlW1Uq?=
 =?us-ascii?Q?IRzwmN6Qm/JZxfBxvCh+06cWGMmW78lOoG7KHbF1Not+JS2TdDm5umSr4FGI?=
 =?us-ascii?Q?zCeL+vUVSaydpnP1A4XlucH6Eu8FanPCLd+uw5kq/nPLnE5v8EB91I/s4ZZX?=
 =?us-ascii?Q?LPKagu6FK3yRKWA9Tsqh/ABqP+snAmNiTTrEbzf1H6faySS32t7qiZ6Jnr5t?=
 =?us-ascii?Q?xYgsf3VL8j9wdeWmUykRGHWF4MToGxAq8j+i7QozYtOlyj23yai5foAOn6Qk?=
 =?us-ascii?Q?SnVoLm28Pc+yDlsvvXiAniv4nUubdb4qxWQOn606E/T2DikDEDRMyD5UST5y?=
 =?us-ascii?Q?Hja9g5ZrU1SxlYTemp8v+MVOSP1NmlZ2oT88qyJ/F6trHUIQ/g77SJToo6r3?=
 =?us-ascii?Q?hotfBsWb1MnDTFDf52YGkulhhDuSDODO46jUsompuzold8VU7etEOOqN6Eek?=
 =?us-ascii?Q?wyHbznj930WuQuRtdnagkU2LuMwTzx8Ncmq+ImKhQnvl7fWc1Xhswt6pJPyc?=
 =?us-ascii?Q?2hb+89qQpXqfV1l/ZgwtXjH0MkbAmf7yEAd4Tsb+odZkvQ0rrRWpQqK0Dr1+?=
 =?us-ascii?Q?YZGcRrxxRUXwdSJZfZvLxz8duhVLK66h5HWX97PdA6M2EYZzI0G7LR85CMcZ?=
 =?us-ascii?Q?cYnbzJC4JHUtGlLLA7iTU3HKjupLaTHavQNManekHBvotfjszEJOKxOJozq/?=
 =?us-ascii?Q?nqe/vvY7jCiYZ5cqFRVtkVhkuIxvvfZuixJikOJHWrWklPNcasR9PUZM+Srg?=
 =?us-ascii?Q?fNGt0mQXKjlnAma99Iv0ObRFLiVtfVZEf6/lcgw4TcTS5ygHf3PB3orBuzFd?=
 =?us-ascii?Q?aPLNPoP3XPudO7IGs38Zgu8FoacaG4kfN0KyPvqrxNmB4rYZe310IiC9JWUu?=
 =?us-ascii?Q?UMULZq59jNgxv+9tRh8gx6mKv9Y9A0Lzwm4DgPPJtGcGsGeHcn/IuySBzWOy?=
 =?us-ascii?Q?R4QWPSdW6UkEqKVinwcPm2ZKBQXDKagM0zoUMhalOSLkQKWjHgAstAN5imKH?=
 =?us-ascii?Q?k3EdfwbhgcQdI65XwNy9SLoNrJhtscWR7qi25Sl7yg+nLmQxQ7PgWONJRTyt?=
 =?us-ascii?Q?sRgG3lfPeQd96z2lUlgRnsXm9VY8AiQyBpnTsBiPHEuAp4NqJRoa/mKgHB/b?=
 =?us-ascii?Q?PsN7p2GPKt11acuTCUkbVLJSiL0cKDzbRM1+KabDDugxn/XnSX6LHRp5QJj+?=
 =?us-ascii?Q?44VPf2jWIOUKsb9fQSiEI5xRwY16OOkv0rW963/UsSd0WVm9JlIUPl9dIT+X?=
 =?us-ascii?Q?gA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb13315-4816-4340-6f35-08dd3f85f7a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 10:24:37.3995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JPCFgR0nkahEDB0g8/jWPvtqV/JLHLWxoVi6zBPgs/McWOs1u3hz7FFjvXLhCM8yzM7M/0aRLIVR1UT7UEC4IZw65qUC0rc0+iuHee0PPkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7152
X-Proofpoint-GUID: lIgQCVY6PO2ubZ-mxO_M3Y5Ep6mpDALc
X-Proofpoint-ORIG-GUID: lIgQCVY6PO2ubZ-mxO_M3Y5Ep6mpDALc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_03,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011 mlxscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280077

> On Mon, Jan 27, 2025 at 12:10:21PM +0200, Antoniu Miclaus wrote:
> > Add support for selecting between single-ended and differential
> > reference input.
> >
> > Input frequency boundaries are change based on the mode selected
> > (single-ended/differential).
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> > no changes in v6.
>=20
> Why'd you not pick up my ack?
> https://lore.kernel.org/all/20250121-crumb-dispense-
> b455b591481a@spud/
I'm sorry, I missed it. Should I send a new version with it?
> >  Documentation/devicetree/bindings/iio/frequency/adf4371.yaml | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.ya=
ml
> b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > index 1cb2adaf66f9..53d607441612 100644
> > --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > @@ -30,8 +30,9 @@ properties:
> >
> >    clock-names:
> >      description:
> > -      Must be "clkin"
> > -    maxItems: 1
> > +      Must be "clkin" if the input reference is single ended or "clkin=
-diff"
> > +      if the input reference is differential.
> > +    enum: [clkin, clkin-diff]
> >
> >    adi,mute-till-lock-en:
> >      type: boolean
> > --
> > 2.48.1
> >


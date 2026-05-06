Return-Path: <linux-pwm+bounces-8792-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NIKA94D+2mbVQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8792-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 11:03:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7917B4D8478
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 11:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABA403045B1F
	for <lists+linux-pwm@lfdr.de>; Wed,  6 May 2026 09:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1A03DC4A3;
	Wed,  6 May 2026 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jJYHkXeb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2493E0C7A;
	Wed,  6 May 2026 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058158; cv=fail; b=gNp3/ZnZQkgyxfaO90QPTJPE7KXiNavo2ytWcpwHygipsNhykCxKStMCAzfYO8iKhlFpxtFKyu+diq7U/2c71Uw3lO2LZn6WPUBQdIvpGQJMoO6wUEEmG/V7anDiUuIH3cw5gwKib+YynoutfslepIOTqed49iUvrUzRb9QwJww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058158; c=relaxed/simple;
	bh=6ZvfvAbH4tNDkgB5jZwPlKkYP6E2sE7GQk8zsOXKwOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HQnk0bOva6XNejcDK8XhulOsHFrH2qlLZEsfewtcCOcutfjeB8kXv3QIltpOeMPHIR3O2qQMc5fCkbHlJ37cU4ihCPDAyaUaMKxGlo2aoRgs4yPswZ6dfZQl3kjHJO6NXCyppj9A7ZMDLP1GXUkyozsmoTIU/UCONVuL078Q3Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jJYHkXeb; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64637AqJ630414;
	Wed, 6 May 2026 05:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=irYfr
	SrQyhOQl2ScQ98l7fCQ+b+6R1+NFymOyaxqw6E=; b=jJYHkXebQugGZUorZ/vml
	MBOpS/0YnnLelEHmrkzBpeq/9eElBAbfAUZrxl7Qs9Q2ECThzahw+IvUXXLKAHTe
	/szfLvVx8hZC4IvWNFAKB1gQY9tz8lAJai/kv9DqWD8ODKZSmInGwCNbVXqWYmVa
	6lcS2kP6wnTDatboce8zZaqMEFG1u2E/eOdmxQYqofgwAs3oa0TJmXU/vXFCC1Xe
	fhlbaa4asf/UI681rSymu1u3+SXnwzOgoNqPE54QcYlUndsEIW7kcg+jIrig21eE
	Dg4m8lQOO+IPwc8EJzlZLvYX8N9kYXdCCcFttyhWzMRUbG8jiAgsfJhyABC97btf
	A==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011045.outbound.protection.outlook.com [40.107.208.45])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dycmwvqnd-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 05:01:53 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlMtLubg18OgzyP/Z5rx6tSgdfuAsxA1u9qnA8Y5nZUNL4VWXYkQCAtoN2HdNTQ5FJaMln0sPb0IMg5gD3GwNe1KNWPSplLE247t41OLvMI5MhGM17C3XK4r69GRBaiYR6T3Y+AcgqAvVUvMBCXespCNvIWx/diOt2A8Vrrxvykx4ZGV0m3rFC6f10gDCRQyKx+w4Nw1S9fm6ivJM/fLUmJ/rBjnEul5pWTVV7p7zyAKL7AG1SlOgDCcL3jAQT+/bKsg28d8WWK5QnMZAuhTa68fNN0FB0zEqQE+cgHrXRVPF6qrxRbGcTNPfHH/NTE8kb5pNLQn/IvVWHb/RqNvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irYfrSrQyhOQl2ScQ98l7fCQ+b+6R1+NFymOyaxqw6E=;
 b=LMKo5Q80l/qnw4tE83lYrmwjG74jHvq+t7TM1ZBiESvrooXYYnoEuXx29B+ajVzCrsInsJ+RESdyQFx4U5r4YP9WPq6PY3rDm13UixmHkoPyCxDzdD5DLVTgy/RbjAgmCVWmeP1wja62mgHzhXxBlIpcg+leuQJIiRTqHNsvOm2hrTgeRaPFYLjsLGdFkhzUfjpPcptiYhgyLJtZ17GuPwNEsbBcmGc4/kMTqcMjjWXVhrpb9LFsfZT6rnYl3CdDC8gIkAxscLOMEXm+JD/gc0mp9AF+http35YrIJ+cEAOchEwL/nOAD//grz5KC6sSTYX2grMK1R0z12oqGnsmuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SJ0PR03MB5791.namprd03.prod.outlook.com (2603:10b6:a03:2d4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 09:01:50 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 09:01:50 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jonathan Cameron
	<jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<ukleinek@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski
	<brgl@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jonathan Corbet
	<corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v9 3/6] iio: adc: ad4691: add triggered buffer support
Thread-Topic: [PATCH v9 3/6] iio: adc: ad4691: add triggered buffer support
Thread-Index:
 AQHc2Ip5b9xysBU1HEufEOvMimkIw7X9hksAgABEDkCAAaouAIAAGZ6AgAAWFYCAAP3HgIAAGCDg
Date: Wed, 6 May 2026 09:01:50 +0000
Message-ID:
 <LV9PR03MB8414D3B18ABD735D8D7E0587F73F2@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
 <20260430-ad4692-multichannel-sar-adc-driver-v9-3-33e439e4fb87@analog.com>
 <afhReLCsEdaEOT_H@ashevche-desk.local>
 <LV9PR03MB841441B282275F8F36FD12C1F7312@LV9PR03MB8414.namprd03.prod.outlook.com>
 <20260505142640.49cde0ca@jic23-huawei> <afoFjaUBcGXeuEzH@ashevche-desk.local>
 <20260505171723.390feb20@jic23-huawei> <afrs9ZN3moV157fR@ashevche-desk.local>
In-Reply-To: <afrs9ZN3moV157fR@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SJ0PR03MB5791:EE_
x-ms-office365-filtering-correlation-id: 61c48a62-a931-407c-1cca-08deab4e1c60
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 uotyaDoG4j1zOGwC7GIFvYeHFsd9D8e+lipep2RJwtMvOgpMDlZFZi8qiZZhPZ3lt3tVGEwrMI/DaEzgJxS6b9sNvRJXPVdGdtfua/8Q0fNWdxCk4oDxY8dKiVz3uExDByB/NO/q5FoaFcZB4y26mv8kcySRpWfpLVY5JUi8BiRUiXafZaDRnVXDe60Xz7hUows7komdMyd+e2oOt63fvvv33WlDwLEWYKf07l4zeRwbs2w0TvV0Qu7XnIPKc0tWakgTtD4KDWBeNX5NbeLDIFgxmexi62FwbqPnKA7QMwU5oNMx1EQ4udlDzNrIdeTyf4jo1ocxWDuSsX4biZ5SmqEk1QIfehOpEw/jNFYdyMs/HDDp7+sTHG+ZFN3NDpjZZTRxqwF1lLCLVItbypZfb103bZ++tg4lcjpzRfLeoJn+D/3V7gMLF49LU8IOiGtSV6mRfdQ526EV0xUpvvPy4enT+vwv/aoGuzJEDeXphs1lKWqvDiEieOHYpQ8S4Ed4uosNQ7RhC/J8MN6FCo3D5A65ZM+v82G0JQtfay3nN4iko5j0xV3u9gE71vDUPnDK30qKdlonhlRLhCDrmRuabKTRcPB1IAphW213VjpXBiUsVLnyssAE5lTL06l4alAizK1l2li50jEqjMcmt8vz9MlYWOcO9lkYC3aKI1zi+Z1zHa+NqYapq/lmES8HDAAnkyqWgwyMxvqSyDmlV3flJIraU6G2bROoQWk/8vhR8pVeAUxjEbnfpaHb5f08zyR0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?utxAoXu5WCOA3LTcCYHC3lpnOTLF7AGUQRj/+1IId/WPZIl+PKRVpRPsyD?=
 =?iso-8859-1?Q?bKS8VJYNWACdzVsr3ht1VFofLq1BK0bY4xdldftTpZ3SxIIQCbq9Exdz49?=
 =?iso-8859-1?Q?OHakK2WjRFVIUQEXA6HUkp1aZ6GquUxXkzKTQbTPxCJsLoFwzwct8dVEvS?=
 =?iso-8859-1?Q?Nc3qWzEo7AeA0SafTgYONOHdQT5pw5U82yPc6Wv1Ka2XOv+yCn2FHd+NNF?=
 =?iso-8859-1?Q?YEDwtwJ5QNIE7hEno94+0A9M0WOtbBiWxGiRsx87cg/lF3fECLkz//Wae+?=
 =?iso-8859-1?Q?OkqCf52BADqm+GjF9S2OGm7yNI422lRNQyFiTLb1Sjtg6Hi5fpWjWree5W?=
 =?iso-8859-1?Q?f19XXxt7SqVSaxRLFch0KP1+0FpEtyg+uxrrCyrjDD2vhI7e1VDahyiyN2?=
 =?iso-8859-1?Q?qkE04ZjGfg5qhaoh5TDM1eS4JGyAvw4bcfMl4AEAFH6ffe1BJEel5s8IRF?=
 =?iso-8859-1?Q?v7yR734C8pBSq9B2ixHSq/+7sPeb3hi2vLQkSlBrBovpHcQofB59IVy8Yd?=
 =?iso-8859-1?Q?SvvD7ZNX28VqPo7O9ndtDu6NVVSpRAqRXBUbBmykgeW4vQEjjjE1yuSZ1x?=
 =?iso-8859-1?Q?I+60z0+kdWRPeSwTKo6x2/iTKc0ieTJScTKM9v08vQrIwutd8xMlWNwhHY?=
 =?iso-8859-1?Q?O8qdRj1rBPUWymCPZz/1bu1d4awR+SVw1Mml2C2S23d/hzjmXuWvv6JPtI?=
 =?iso-8859-1?Q?bV7zrPT06x7EojpgPs+daN8VqTDhovuuUQfaumz+x/IOc9WSrZI6DnI2t5?=
 =?iso-8859-1?Q?k2MAE5OzCQT1mAHEkL/ywXzub56id2YnOv2HSLNG1qpDE+iv0XYXovC1n2?=
 =?iso-8859-1?Q?ubKpZ2G+1xykTgbwNH1GmTHuHerpYrrEtuyYgD2fvax4fmKbgaGFBz226H?=
 =?iso-8859-1?Q?cH0rn1SDegVL43aJRAefQv3UTaeS3tXtQisJdVaF2uSGd0Y72+6QAFGKtu?=
 =?iso-8859-1?Q?mbs219J3FsHuKr8dy4QSFNQfROOBWUke1GxQ0BdJLAhs/WMOV+ijl348Ow?=
 =?iso-8859-1?Q?RT+9CmiE1ysyYsRZyOQ3u0tb9dknPfTyta7PVwHG7bc+Y6z8/do2Jf/ZUZ?=
 =?iso-8859-1?Q?WQnme8yGJ8UQHTr780SiMH2qM36KzfLCqY9w3t1BUd0a5JF/+mig5spgX8?=
 =?iso-8859-1?Q?Bb80vjgKX7sKrOVhnjg4b+M9APhQXQnYH3Z2NFhSChHgZ7qEPUGzdH+KPP?=
 =?iso-8859-1?Q?PS4vqb6t4xnpm4SnioqOOXF+I6Ix6Bdy5VGIWwXZ3g2ujOEU+i0CP/TNSQ?=
 =?iso-8859-1?Q?C92dyU5ds2Jfwo0E7UnSfVj9doB817a0j08GmxFluuJ7WDhShCCr26WIcj?=
 =?iso-8859-1?Q?PKaAL2M6F/bK9KGKOR6et0gVuC441ThSsHIgUBiJULqcviqvQOLT3GMv5/?=
 =?iso-8859-1?Q?Mr9vMRavPhxlDH9oFrsF2lT5H8wK6pGG9JlM1zbxdQZFqOBSy6OfNRWgS9?=
 =?iso-8859-1?Q?UIkhxFXdk4axORlR0ekWzSKNcCclXsZ/6Y6h2BuJwzz/w2cH5V1fzjJwMy?=
 =?iso-8859-1?Q?tQj6fdD1jdUp91hh2RDmi0115/SsSwj7F3/CrrYdjIc+fm3sJK/mZizvly?=
 =?iso-8859-1?Q?AWZJJWIAM7aqXcWrN7+S48BwgafrR7EJY6lNew41+WwcrauhhHBLfUNTMQ?=
 =?iso-8859-1?Q?0xgHHoT5UiHgrtJaYL/lbiLpUGiphS31g5JhEZU30sRxNqaftNE21grcKy?=
 =?iso-8859-1?Q?OigSgtG6MymAVuJhQLXaBUgFCbH3HxslQystkBEdvUgBpXupF6cWZpnKah?=
 =?iso-8859-1?Q?5S7AlenqVawOo9OC713yzHFk9S4ZtHkCoQFqPQNouDQCskCgQ5KZ22qmw1?=
 =?iso-8859-1?Q?P7SBtTtd8w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	rO4pWS6IMd2Ojvhm3ZbtDgTDjUFcZpwEzYV5+3IwEfZD/NMEVBO3d8G1u3Gl7nE/Ln6dgIQqR0tbDZ0qsVIJbi9LjFLH/Ekg8b2+NjM2poCXAxD0kCm/SAuufl040lCsPv5pGsOMNUfvP6UCjVSFmzXgNKP8H1p8/p2SgIYlyoxTy2PNkIDmtfwcwfSS2ZI70OKdEZra/9PA+gCP1AcPnPcjvG5pBGJYRfVDNIwLXxo2qdFjvhfWKMAs8SKJ6fqVwaS1NWHqbL+H85vK8cJ/PXNprcm24yH645Xb+b0WsUvMVCA5OkjJQ5FWIWNZiYzgQ/H1QtKD8dCmRe1MSF8JvQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c48a62-a931-407c-1cca-08deab4e1c60
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 09:01:50.4623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iEwgtoHvKooCfByp1D1tC74J5RZLnLEiiTOCpSL1XQKLkuE6En1rtiKQNeAlbFI42XhXLSHqCTlJ6fFx84dr/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5791
X-Proofpoint-GUID: LSHSd56EByJlUpGBivxv_kcR9BNfe0a3
X-Authority-Analysis: v=2.4 cv=C6/ZDwP+ c=1 sm=1 tr=0 ts=69fb0381 cx=c_pps
 a=s6FLI2cSFE2dV00WXjZlDQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=QyXUC8HyAAAA:8 a=Mv9njEWeyrKie7Ml46AA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA4NyBTYWx0ZWRfX1Vh5hyAE6HDq
 pRNLHKOW0fM5o+O8fNoDlrMWMDhrLqI1/T0nnZ4hgoJJud2ZRGtgYlWqbeex/OIr7mRA06+aINw
 wWS8JnKTcW53bnpXAknOfsYWW52Itq+QwON6HOnuvh/yGs3rBJEgyEQ3VXJZTXpdaUe+1EXP0yV
 U+qfgBD0wCbrOmm1xdSHnbb2EPO17pkDDBTT6xpisq7tPYecrO6hTSfChx++6yxIM879BJ7D/hP
 Cxf9+eQt8CmI2Um3JKwfIC0TZ0T3RWDt+IiFNjOs/0RFT+yJiXQppN/JOBDqiXAxJ4XhUsCnSNP
 KCo7YFD98wNI/Q1Fmbbk3GL1/1MpDAcNjhgIyL/cfFZWTDiESOsP/KKixWkLm2x1om4r4ZgSUGY
 ioLuERYsYHbC9z2yF0XyKDcT/0A5v6hb9T9UvoJFwiQPa3EwAbiXMdVt95hK6VxgBnIUsEfzVIY
 LHqq/cdxVEr4Vp2z+8A==
X-Proofpoint-ORIG-GUID: LSHSd56EByJlUpGBivxv_kcR9BNfe0a3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060087
X-Rspamd-Queue-Id: 7917B4D8478
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8792-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,LV9PR03MB8414.namprd03.prod.outlook.com:mid,analog.com:dkim,intel.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Wednesday, May 6, 2026 10:26 AM

...

>=20
> > > > > > > +	for (i =3D 0; i < ARRAY_SIZE(ad4691_gp_names); i++) {
> > > > > > > +		irq =3D fwnode_irq_get_byname(dev_fwnode(dev),
> > > > > > > +					    ad4691_gp_names[i]);
> > > > > > > +		if (irq > 0)
> > > > > > > +			break;
> > > > > >
> > > > > > This is problematic in case the above returns EPROBE_DEFER. Can=
 you
> confirm
> > > > > > it
> > > > > > may not ever happen? (Note, I don't know the answer.)
> > > > >
> > > > > You are right, thanks for this!
> > > > I'm missing something. Why is that a problem?  Driver will return
> > > > the error and a dev_err_probe() is used so it won't print anything.
> > > > So probe will fail which is exactly what we want.
> > >
> > > If there are two IRQs and the first one is probe deferred and second =
returns
> > > an error, we return that error instead of the deferral probe.
> > >
> > > May be I missed something, but I have no idea how in this case it may
> return
> > > the first error code in such a case.
> > Ah. Indeed. I completely misread the code.  if (irq) would do the job t=
o fix
> this.
>=20
> Not really, as we are only concerned about deferred probe.
>=20
> 	if (irq > 0 || irq =3D=3D -EPROBE_DEFER)
> 		break;
>=20
> will do the job. But again, please double check that the
> fwnode_irq_get_byname() is even capable of returning deferral probe
> (probably yes as my weak memory tells me).
>=20
> --
Hi everyone,

I checked and fwnode_irq_get_byname() can indeed return deferral probe
and the fix I had in mind is like the above.

Thank you all for looking into this,
Radu




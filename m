Return-Path: <linux-pwm+bounces-8274-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GycOrIkuGmNZgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8274-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 16:41:38 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3DC29C9CD
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 16:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B4A93055058
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 15:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4E03A0B36;
	Mon, 16 Mar 2026 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ISEe1HuC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5082E39FCA9;
	Mon, 16 Mar 2026 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674990; cv=fail; b=Y1qM6ucU3aOYPVOckotIrxvP7y70wvJ+JZNnYXA9O79oD4h4KsMLe3bSnyGPuPzJTu6p6b6L2tMBzkbXC3wv6IWeRaj61ZlJMJIOHepc89VWO4i+0jtHFLjO0PMjS8t8SWAiKfUcOcuEuS4QvhsIh45fEopntn8tXhFqUS4s+Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674990; c=relaxed/simple;
	bh=jp/IM2oMdTP3B9g/noqbCnSNmOHDiYx1vU8FvRYeIMo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RTRoc0CHIvnJY0ZCjSy1u71D7lzzSDyl53oscXzt0H86hjP1Tuh8k5TpVDjokv4yXNWjCLj6jXXo7/7MrKkkAdZXLwlyOnnYtnfFOaJzSuZeq02hDfjkx/v1g7VVhwWZeGLJncdG6ccfCb8EnsLVHcuakjLEaiCCjiDXKcC7GME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ISEe1HuC; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GFJZMB3761351;
	Mon, 16 Mar 2026 11:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=r93d3
	6xC9pOkbHFXlAjAKHFD+/6KGdMPftcZFvtls/s=; b=ISEe1HuCLnlbe9vB87tJu
	MDhLuTQlXaPEExtNzgbPacTK1cZB1QV9sN+3pkEXyCUHTaiRbtiGizrEw/6gJASd
	r3uwvCmW60NkuQe+eVE2sn56nk4wjJ7lmdywmy10U6ZapLYNoSGXtZ7ca4FJJ1FQ
	XrqCh6kFmfIVmf45lsXtGfSK9DfUbYApisBjeRipYpmoiOYP5dUBkBIuuBXiGSRM
	dju2hjBkl78bnP5mlFuLPHau+/0RBi7ZbolFnOtb26c4lrUYw4BDnQ+WSczQuF4X
	2g1IGibjZ0T27jsZTBE+L1Lym3i5xq/ZjohGLj+XBJT9dPz9cntya43fJuVr489b
	A==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010068.outbound.protection.outlook.com [52.101.61.68])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cws0fmqq0-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 11:29:26 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRQ3Q9ZmzRoQ0vOgv3Cbac1KmSCgau1KiEdi/mT1jcHV+zKgTIf2sT/xLer1EI4z9A9gcfD1c96h5YX8I6Oka9PpIsHNrrfkO68F1hnzx9xfPnnYb1qI67M8oYaWRQU2eGySJyzJqjBMLqeL7K5rczm7VweI8KBnHoOdxf/cNS7QxwjO+aejksFDjMo97j0qAcejkrWEVdk34MgXSZTmRudSfPT22C3plD/KOel071dZrr+anTnZwS8a2DMPEK+MtC2eTgG5ug2QiJKpVDW7fsya3qeayBUcEvRbPGaQA62X2p1N9Mk3tB+3oAC2Mn/fnIGZnKFwUcXTlkZIWFHMHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r93d36xC9pOkbHFXlAjAKHFD+/6KGdMPftcZFvtls/s=;
 b=jAxX6oWKn61qT2PPXLNfWxoKrYCuzoysgWj2Igx1FOINrQcTEZqPEAar9R4J9qiLtEwplV5BzLbP1xYh3BmlDendRdsbrS+cyPWUzKrO2NfRYsipqSuNpEWCefJxdDvtKqhsticvh3p7nBckVjK6gayNrNowSSK+Yaph2taP4GrkoPAzf4aF9hbxATmXKa7H2ImUMMyZbFr/pdw8v3JE4i/vLfFbvRdGsHdFwVmRqenD3QZvddDJeXsdDzLTqqPfkAYziejPwHAEiZevy4I7oGIHqYjdKInzp7r2EpDy7R1YCyVbHb93SyIVH1fhDDWdW+uh2d20dpVJ4JrketuJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by DS0PR03MB7704.namprd03.prod.outlook.com (2603:10b6:8:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 15:29:04 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 15:29:21 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Linus Walleij
	<linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>
Subject: RE: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Topic: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Index: AQHcstE9wdxbJGrMMUOmE/HdBho5IrWsSumAgAT5J6A=
Date: Mon, 16 Mar 2026 15:29:21 +0000
Message-ID:
 <LV9PR03MB84148A9A0A7F6544CF370B7DF740A@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-2-b4d14d81a181@analog.com>
 <abPtv0Y_QWYoMuAO@ashevche-desk.local>
In-Reply-To: <abPtv0Y_QWYoMuAO@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|DS0PR03MB7704:EE_
x-ms-office365-filtering-correlation-id: c2358a0c-d9eb-4d1e-73e0-08de8370cbc2
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 CHmx6W7vWIjKTJhVebAojUVujXvWLRftGVHkdA/tnKfK6gIprPrO8cYUwJu31BbcFrr+xhGkh4kLyLUaoY/LoPQ5DMsJM6Zxe+uZ0YvSJq54E7r9RZ1FlQBJyyGMEAxSveacchZ6q3vkY5wpnvF74WelYCZPUz3ndO+SNQcqTbPLPfy/K66e5IjXnnli3elOa2bX06d59NZpAENmqZllB6aBlY+LcKEnxPiWoedO+6/pTtGQ+Ht5cKQVqp1uRtMct24dPdf6FKpGTOmK30Xm1PXxacdAfQ8SqED9sOM6L0g3oEIvy4klSLuV53+RSCneJMwG2dnyqulBFhxILPyiKgJZaSkWt8QMfbbtuEX4NLXY/jTcsHQ+CthaHFjlb3yPdyztTJUcl1CitwTC6sT4kSV3GUh33OcZJtUC9+VPd7mWrtk3VAuM424frhid6ViKqVN7CjCUOpnUh5PPkOauW7mhjIUi9P1qaZf6dRF3xdNt5Z49/2R8d40jySWYihC3zvJaeh6dFZGascJfsLDiQdorW+3UfW2knYzHP4s1PV1p8DXlSZvNpkTJR5v/tbP+51LB9vDW8d4zW1/bbjgtWg49ZhPO5zKHzR2YqrltLnOfS0svZJoX2Y2XBrx9z2R4J9dtJqKS+3r/nqID+VZwtfHn2Dnhq7lddg7/y9q/AfKFPWR5A5q2xFOU9kXEQSz+m3Jq9mqgdKu04BB0mitmr1sbfC1Wv7RoGnCFMJnMnYw2PoPjVuxAP3oZaf/F5L405DcZX1WGPpqvQml8IDsiHMLDkgifbr+R96tjw/JYlgg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?UYGqPlnMRbq/Y2EcWoJCq541w6hyMpR5PQ7u4Kx0FnRUI1cSBStno3Lc/k?=
 =?iso-8859-1?Q?4f9GX61w1pdGJr8L8hkg2PJD9K1cOowEGIcmGv5a+BHXRdi3x7hQJEBgyO?=
 =?iso-8859-1?Q?R+qkaTDfVhxgKDE6OQIFi5LGtN6kOC1zkmyqWr9OgzWP9B1Nk6nb2Y4SW8?=
 =?iso-8859-1?Q?E3qt8UY29dUcp4c4wD+eLKJ0GGw9+ChTxF5Tmo0A4n3yqJ++oNju73jH2i?=
 =?iso-8859-1?Q?26IaaiWVHuKZIlxcZVjHPx6WVnQxZ8P1uBqyGob3k+JQQGZLZbFkKLIIgu?=
 =?iso-8859-1?Q?gzYKubjQViQOhMUeWFdwp7WoFl/bRLO6K1YfxxKLTbrKPCFdpEDDjqYw3n?=
 =?iso-8859-1?Q?27ij6x3mcsi/jbvUpreXdMveh++tqcUTg5X3FxGCyplO599p6o9Rosiqbe?=
 =?iso-8859-1?Q?HnB2coQ1K0yMUvx4hbxdb9N39M7+Ob5RiWmnQFygk356uEaPh7KCRLnBtM?=
 =?iso-8859-1?Q?UIFoDgwT+eHCgolvdQrTWB+LEG2H+n2qH/JorAISHGW6k5QRTlUh4izaqC?=
 =?iso-8859-1?Q?cCFrCB5CEh0tssfCxtOBxsbi2YB/CxlnL3k3wDMx6GDv/FQwvWQNHrtXFS?=
 =?iso-8859-1?Q?loNZlh/RodM1/iY9xtvBHZbdwcL8gf9h3TTEXPJzY3xB0gRIue6pTlRN1u?=
 =?iso-8859-1?Q?wvu840kOfkMNkaIu3pj166Sm8TLsUXG1xa6LHLhH0PuEgcKc32pbY1SEUp?=
 =?iso-8859-1?Q?1V0JCTToWZokP8tyykB4hu2xYu2qrhOkAWRDHolVXGHDTLiEj9+jKPz95k?=
 =?iso-8859-1?Q?Yuknl6gylWEu4rgcDVXmdF9nMjnthKSqLu5D6KEfumDncc4RGosuMHqdos?=
 =?iso-8859-1?Q?d/KoDlElvXvj2OpE7JP6WsL+EU7Lovz3xCBNPamyzQvSTOqiM1Q00evZoA?=
 =?iso-8859-1?Q?NgYaMfHmAtlhttolhJHckNhIqkp87u0sAI1dBuB7FKYePV/hvivEsfew5N?=
 =?iso-8859-1?Q?9+zDIQ5+a4fPi96DIIo/ydO8SV/vc3l9n56P5lyyjDIPNp5F/S7up/uuWM?=
 =?iso-8859-1?Q?FNrW4lznmvSz4+Hm8oVgFrV36xLmQVVz9T25rl2XHb68cZWenBC26Gqg4b?=
 =?iso-8859-1?Q?6tAiwTew+MKjPkQHwI/M0JGf7PrCQjaf3o92liaY06yYL51zI716fgRBq/?=
 =?iso-8859-1?Q?KpVVvAuTeMF/1erXa0kaOY+RH6ggwT2hbtf6DNi/jg8sdAbUm6ppatIsFK?=
 =?iso-8859-1?Q?L8LoQKriDB/93kHbPtrSrokAk4xbpIDF7qxDR+Y/0BbxULiyG1+GySnYHa?=
 =?iso-8859-1?Q?LsOdggUiyu572YRxwRCwsLAObUQHRztQL9AKtnzkf3imv6uXFQd5xajzdE?=
 =?iso-8859-1?Q?QuJ5vdzuhSsbEld4VWSUCbCgRgPBpqyMqChRfpQwkJkFg/B4DAz7qKqJNf?=
 =?iso-8859-1?Q?g39S8ci9U8AWM+BDbyTGlWw2snBAv31JHWphvnBa5VY86HBy9RZwzUH162?=
 =?iso-8859-1?Q?SimqtLzMRIFAhraMiLoasMCDB/cLu1ciBDVTVBGhNyB2ICs3HN/V1arUed?=
 =?iso-8859-1?Q?8KAaHGeS5FxdBrIwYc/fpMGvGuDPq3nM6V68X5HG7zyVe/BxTd1xXLJX85?=
 =?iso-8859-1?Q?iBM+iqCySL8t4+1BM6THkd+KCaeKHKGRu3e9R6dlZVcdY0mWloFb50M9tm?=
 =?iso-8859-1?Q?Cv/HERlPlS3I2zAUQTv6MWAzB3opuzzHwP5JHhQ9xL9u7NOQWJxSZ3rr/P?=
 =?iso-8859-1?Q?NooQa4g90h9dhz4dSCBF3fhNHdZ8wA5tKu18B9aUQvW8aTDN8kaAuibkW0?=
 =?iso-8859-1?Q?YoAP12uVpDrkds2NVUASL4dpbrpu7e1qNg3MgKCpVISV2w?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	unuGN4+Edv+jPDW98fWxr7SzcD4ZTpDKFuE+4n8bYLtdx6xr1sBfHrH6KgecrfgKNz62pNQBzlaWPC96WWsMQBvRDYXzqJ/5f0SBSHiuzNtULVrEJpZeBeMIhQOQJDQIBdq0R5tv73vx7p0aNl8zO6SKACM6fxntWvOSdwZ6A4pkw4Lmh08M5GJroyORcMr8hbmagDW3Ukx0HhmlQ6KNYF8PxjoQSJAy7FYcpXOkPAgxei/jn9KFwDDBn3KhXCkXDGTItoN8IXX3MSSy8XyG4LR1Z/CuZUQjOnQAa4omq2g34b4oy+TfstDEiewGu/EE7m8IoesFYBmi89wOWkldZw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2358a0c-d9eb-4d1e-73e0-08de8370cbc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 15:29:21.0709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0vg41v7SpQPHK5D5eGGGLgtoEZN5cOFymE0ATBHO1qNOfPoBBq9chLtIxZnZTbNeqBB9Q+E3Ba77r2HmtbxU3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7704
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDExNyBTYWx0ZWRfX9/ZkYA6fYqoj
 bc3XEiTTRVjUDI8Pn52cHUtAWY06pemWw1Mvx6mPz9tS0FXDOKhMQKElxosyer4pLXlLzpJ/Afw
 buyuj26bgA4d7tfpftXwBNHB9lSfamN97mYMGmt/MkbtrkSZ5bRsfVTi+EK1SzYRNTqtOWu3+jl
 6v0n0LD4oHJ2R82ng51EL5fkzaWUXDxxPyWfXFzPOvLdT0C3GY8sDZVu7xxeLH+aoZVulqFxAyJ
 U+Vwj7f9KiKbAMo62Hqbs0LeFonSXJvMV5EDFReD4yaE+2Xgq4dF54nq/y6SIIvetz5ODtOSE7L
 HTzYvK/8tlc6n3srsuEQop7KJhdbP7vlg7ooPKk01sBYRl6CAwuc4ZL0SMJlN+dbLyE9qpqFKhq
 F1fNhmg2cGZ8AsC911OTikirxgmYzfxfEJ+dW7zNDePNQEvcRAOj1+G0y5JbplmYU2lqXZGq7G1
 NIVaRe3JJUliNFT6psA==
X-Proofpoint-ORIG-GUID: DyEZRUsTwRCAgmdkGiwTwmWPfw80kVt7
X-Proofpoint-GUID: DyEZRUsTwRCAgmdkGiwTwmWPfw80kVt7
X-Authority-Analysis: v=2.4 cv=BbjVE7t2 c=1 sm=1 tr=0 ts=69b821d6 cx=c_pps
 a=UdDD+omNl1Ext3Jod4IcCg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=kYohnxZ39oIpYLYyQiUA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160117
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8274-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:dkim,analog.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,LV9PR03MB8414.namprd03.prod.outlook.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EF3DC29C9CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Friday, March 13, 2026 12:58 PM
> To: Sabau, Radu bogdan <Radu.Sabau@analog.com>
>=20
> > +	u32 acc_mask[2] =3D { mask & 0xFF, mask >> 8 };
>=20
> This looks quite wrong. Is it for sure like two 32-bit stances per each m=
ask
> byte? If not, this should be __le16 acc_mask =3D cpu_to_le16(~BIT(...));
>=20

Hi Andy,

Each acc_mask has its own register, therefore the u32 acc_mask[2] is
intentional - since the regmap is configured with val_bits=3D32 - the 4-byt=
e
stride matches what regmap reads. However, I understand how this
can be confusing for anyone reading the code, therefore I propose
two ways for this :

1. Keep regmap_bulk_write and add a comment above acc_mask explaining
why u32 is used, although these register values are 8 bits.
2. Switch to regmap_multi_reg_write, which takes explicit (reg, value) pair=
s
and sidesteps the ambiguity entirely.

Do you have a preference?

...

> > +	if (!rst)
> > +		return 0;
>=20
> Is this required? I mean if reset APIs are NULL-aware, this will be just =
300 =B5s
> sleep.
>=20

You are right about this. Also, I will implement a software reset in this c=
ase
as per David's suggestion.

Thanks,
Radu


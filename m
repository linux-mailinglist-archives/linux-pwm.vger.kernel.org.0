Return-Path: <linux-pwm+bounces-8449-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGWuG1MBzGkoNQYAu9opvQ
	(envelope-from <linux-pwm+bounces-8449-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 19:16:03 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A37C36E571
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 19:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B1CA313CFF9
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 17:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AD43016F5;
	Tue, 31 Mar 2026 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="aB17PCNz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE792E1C7C;
	Tue, 31 Mar 2026 17:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976760; cv=fail; b=pbBN1j9ql1PU9ILG6iirdQw9LP8s/TW7/gLcq3Un9aINSUjUG7YyHdPkV0BJXxZtgiucoqSW7wxw4WEi/K0cJcOKb4TuTGITdg0iSuPEHEuN/pTSUVCkXpKfqciyBPjvHoansui5iHBaiHtSQp6AFdP5HnE+uZh6lgrl5A8gDlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976760; c=relaxed/simple;
	bh=P/dY8SarJ4zghE05Ot4c5dfsmrbpQeRNJpjnwHV678c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K8Yyf3+0j5B6e3PapwM4OyxuWR8XcctoGa+StMR/ibD/TV5OmbOy2cwDrihbURb8GSGnEg9vCeU+dOup4yHDZy/3xMS1iULcfmhD6CcbfkvyP0y0FGifTBn2A0WY2EYVu8ckOImXMxDGB6nBvFo1JDiJuhY0Z9lWMAsaxzADkG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=aB17PCNz; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VGukDL1647153;
	Tue, 31 Mar 2026 13:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=P/dY8
	SarJ4zghE05Ot4c5dfsmrbpQeRNJpjnwHV678c=; b=aB17PCNzZcRzmyTwUBN3c
	tHDr7gsgLjtPO0wwSDky2FfCsMqdpdjLHwz2vmLTr8NjdeTWFCvWzqUPgOij3dgf
	GL6hlMswof2iQGmpcXGMlpPR00iZqDbKDEnjny5RcXXOCxAoIr70J8lkBCmdNJM2
	WzMCUvmPdM+fi4gog/Glv1u0tys/LxmBFC2DMEP+ipIPUVPbb6cFLWZ5yZq5pPMF
	Eaav1uIg/xWTxd4w7J+yiV9ijztRhGNLemF4uhXirMF/hd2RNs4MpAcj/nGLFnGM
	r9Ipsrj8ONEtL1RDpxZVqhla2EVBcdf2AdNucO0S1bigXTeswBKBnScCv/2sJBqe
	w==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010006.outbound.protection.outlook.com [52.101.193.6])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d6bw169cy-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 13:05:36 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9xaceNJDbtwjD9gQPRA+OfoYjkksRtQFFivAhWByUnB78O5jwMqY7C1g2nKQXWpr6ihBR4DeILfPBQ+IksN/eb9YDat/wTDbN9mtnTevra0jTDjyhvthzKg15Ze+bJVDCvpH+dwqyDzWJPRu6gDYcApk84Ks1gIEhCGt4XbBJTuRBLuhYw6lNxcVRXgHgjPbVok3j5uiO036gc1mm4hpFujlRyxrgb7g4yIey7ni9V6aYl8dXjtmj7PV+XvO5Poyvd1aEBLOIXjldxNx4muxsrkcoxh7g+sSqE8zarSPYJqAinDg+VxlUfXy3PWTYp3u3ez+32F1W6YaRFwCOOWIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P/dY8SarJ4zghE05Ot4c5dfsmrbpQeRNJpjnwHV678c=;
 b=Bs565YGx76Km1UKvUiKeMq9qMIYM13Uhn8Saz4LRFypiQr4gXCIsIspWrv9R95kRAMIBLoP2pcI+rPw1fFGV6MW9iYvJDCyCt5Rn2XJTixMy5oS4A9ZHRK8UdXET3V/YET615HpP4gd7/1/CXBdvlOpMhZGzoQNyrC4PCpoKbIAl0aAuthP99mJpAtsucLZXPnRoKg8XYDBp4HMHjpRMEUMND71oarVAIyIbvQ5NvKxTbNNBm4UhtCtRGyYkG6xvqNIYmUl3ibtuflsplKRP3zrFapnJ1uqXw0Yiohgo6jG5xxy7oJpSyxrim7qRuuXDJVJ3RFhOgLxwt8zvyE+/nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SA5PR03MB8426.namprd03.prod.outlook.com (2603:10b6:806:475::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 17:05:32 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 17:05:32 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
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
Subject: RE: [PATCH v5 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Topic: [PATCH v5 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Index:
 AQHcvdoCw4o9rbwX3EeiToji+73F0LXCQCsAgATiWGCAADXSgIAA/dIwgAAHTwCAAIeDgA==
Date: Tue, 31 Mar 2026 17:05:32 +0000
Message-ID:
 <LV9PR03MB841477521DF5AB809D0184FAF753A@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260327-ad4692-multichannel-sar-adc-driver-v5-0-11f789de47b8@analog.com>
 <20260327-ad4692-multichannel-sar-adc-driver-v5-2-11f789de47b8@analog.com>
 <acZrthJYQX-h_9p5@ashevche-desk.local>
 <LV9PR03MB84143540CE505514E1CD84B4F752A@LV9PR03MB8414.namprd03.prod.outlook.com>
 <CAHp75VcUCM8aeUpNaFEXnS+Cm08Mq5j+Qp2gYqWP9vCO+9CtQA@mail.gmail.com>
 <LV9PR03MB8414CB05EB794F6974584C2AF753A@LV9PR03MB8414.namprd03.prod.outlook.com>
 <acuMxjX_rsfsJvMp@ashevche-desk.local>
In-Reply-To: <acuMxjX_rsfsJvMp@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SA5PR03MB8426:EE_
x-ms-office365-filtering-correlation-id: d88025a9-cb4f-437a-3111-08de8f47b7c6
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|10070799003|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 ExakmkH0lyGjNDQ8rcdELDncY2sLeHzuI98Yjx/CPIQWyj9qpB5PYqetWrkGQKzqUobXsuWHaoZQsFKb4cKLp8S6DmgiN3OMASlt+k2BB69AslrhcjiXPZmXYbLRHOl0fUgWjsfrcn2wPeDLR1OojX6Vg+R5NgdGsYb30pm6wqAq2qmX1Oj0ftnXNSbyBsyY+uwpLwQbESQcRh3Aw9vBVHy/ZE2YHtwOYQdhffPc8hVORlwKFRH7ElVqcyaEiKaoxtY46U45tWvtWDG0xsfA2cgrEqhm+VobBwQyVWyh1BWy9TW18BS0mn+E7zYkUTwx7fZ8PlnLftmmqqm4HDx4YJEWKw45v/Feuf4jN0+iyRswoeWPcW1qszyRhWbL0ZuGP8+ee6raQjDIHppESTS2HBCustxk4J2inDnDfxslZGT3fzm7djJTVVMn2QwbVDXMMeHPqyAFyru4YNmJBPc5BtV38aTk02AD0r7c/D3igPTujyG/pnjvmmpBOwMQRygaT1hMHcjMmpsyM/NKfTSmyWmKrNuwKzfVTEadZNDMerfpXH5OLfgJj6+MIuU5tuNgUOoC9kuacLsbe8tto0UgPShfEQly7dtFjqFd10lrBCggptg6Qk/iRVPGX5+v5/Rrlxc/l5ZoTtb9T9r1AcA3HzA0QhSsy9zOXXV2s+rY5eCtigcn8imZNB1zkPUqoMUcq14t0pqmJ8lAiiR06NLOsEee7ZWeWuKEZCwr5DWPxUcMMS5RwzNSPJHcPTmc3+Nmb4Bl5ljUqyIwlw4BPRcaVBKT0gLHfE7h+Pum8x5gwuk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(10070799003)(366016)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ZkB8lBBjZCcfxliUEctMPNbHpgZIYgl0BvVVTAFPTFAfN/Gn1IKpyEdfBH?=
 =?iso-8859-1?Q?YWBKgwM7pAS/P5QpIPYlyvkKJR3mo0RYRjFkwQxgj4+Tdb2OhLFcQGjR7B?=
 =?iso-8859-1?Q?Z+yX4EFybA/W/UDSy9umgYGwxDRpTQlvViVUuGP8BwSocMWvhdjDG0mZCv?=
 =?iso-8859-1?Q?cHu5Nfqr16YTisen/jBs1gsM60uclWQtV0F6vrkihj9lDtJ4/qYWuXqaW8?=
 =?iso-8859-1?Q?QLwvJDkQzPOx+J/1uS5AVMTBQ4o9asGcxF+g2kHYn+6Ga6DjuFNk+R4HWK?=
 =?iso-8859-1?Q?oQCuW8Lz32uDRRLxDvv37qok/X4pmJRiu2d1V/0NIwU1hrVlmQsAdDWJ3a?=
 =?iso-8859-1?Q?cDjnReL3CJC6P5gSC3mQaqalvQSXtH5GdFt0icxtusHU4zj8PtzjtwX9oR?=
 =?iso-8859-1?Q?QP6nfAneQS61n5Mv1AfOE+j4ryZF26GO89XEaBCjK0er+A8CQQrOBX6QFT?=
 =?iso-8859-1?Q?ha/CmWJjiOfXrDUO/O120IGyNtrMPOFHIFGCZTsWRE2viQi77CZHmFLftG?=
 =?iso-8859-1?Q?M2llwuVV8j+fwW1MFzAuHmEbVqS4Xr1LVhr/nYR+XSxqIgzAYgkLA8rAu6?=
 =?iso-8859-1?Q?WnPqkqcyxCHbHe4FTwm/EJ7xcw2rl5txZk3TzZVr7sMhUNnH750Tmm6E7l?=
 =?iso-8859-1?Q?jqBqKajwmNaI6DBQHOkZ+xPAzyLlsJzweL568YUwktfNHfRlfI6YjdkRF9?=
 =?iso-8859-1?Q?capvZFr/I+IsxpA8jrORnwJCTIfAY4BffxkYDMHGml2qQ/GMxWTgJQF8re?=
 =?iso-8859-1?Q?d81NKBqRbB5LKgfhcFNj9iBKhegbBnL5OLd6fIG2iULRMN34vQqyjIsf4N?=
 =?iso-8859-1?Q?g0Qzpeb/klay0dVFpivmf13m/dz0QM+P1IpFIbre4p2DZN/zbNbFIcWQRV?=
 =?iso-8859-1?Q?csVydkPde7caAkWMspmB7MQIqc1kJO9RQV0O5S6DAUyH7t1DxyyWJ2IPvL?=
 =?iso-8859-1?Q?r2fw1GZO1i2/uNHB01R6xaWh/XAnbDVmRnh2IzwXTd0WWfKHTmc+DMyPtw?=
 =?iso-8859-1?Q?eqRzi/SFcF9YuPl3ntXs5TNjuXrGKqG7ftbHBJhXTIb3IVfAXh9qsorKld?=
 =?iso-8859-1?Q?GaEzkfDTiywnhI0d2HEkmkWoATmboJOEwRxtgqkPtE2wKmtr7X2oi4DL2I?=
 =?iso-8859-1?Q?TOvm3M733UjHOpZvEzmteXLa7ILolFJFMzcqFXx8mR+o275cMZTdO6qE6W?=
 =?iso-8859-1?Q?LcYANmGoF+zgSoPrEHzLyCs1SnEHqYwbjpCEapBjxLrhrtdnh6X+U8Kx2T?=
 =?iso-8859-1?Q?EZFGGkX3GTNqTjU+DXWfWpzInHShqcVWKoK1nijRpUQb6hRtE20uaLLDzL?=
 =?iso-8859-1?Q?xt515Vbaq/GE5+078Jmbc99t2A8Sj0uIPoPPfBCZXuttng+ufbP7nA1NtP?=
 =?iso-8859-1?Q?BzA5f5bML+2I6xUN5LufQZvBrGtMxYPER3X4yNOLb7KoyROdSQaq43046n?=
 =?iso-8859-1?Q?6Pr4pX961ejQ1Sz33njmt7liL1UJ/6530bOM6JWsrKPqxnmA20Qbih3Nq0?=
 =?iso-8859-1?Q?uj+k3b6OS4PR/Ggff8JAH6ZEUpZMXT9Iva7VratXbXIV4UtWcBJ6x+Cj+r?=
 =?iso-8859-1?Q?nX8owdaUE13qXUrt8NeWmeBBOCIom4V7tHvivafsErDTVy278miPNOAF9g?=
 =?iso-8859-1?Q?zKX1leEMYfh+njkcoSPdC+B22au7Yhn8wFRwzS+fCHDC0Ski462UFKp0aN?=
 =?iso-8859-1?Q?kWiDHr+fBhIMZt5MTR0Fog4jRdieN8N8OGVvprnGLbhW39d0ZXEs4VS9H2?=
 =?iso-8859-1?Q?mrS9u/YP/87L3WVKu335Hui7p+VIzMaVDYdaY2IBytf/0RD6pR9fGxQwS5?=
 =?iso-8859-1?Q?MU5Bb8SknzWvIZ8RJcFXwOB8YODPSCBZ7vU7lkRlRYFOVhKZ+Pe2TqYIi9?=
 =?iso-8859-1?Q?gl?=
x-ms-exchange-antispam-messagedata-1: YSXT3lvh0hqfHQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	qo/icSblPLn4Ed+9eZzm5QCT94rMQ/G+oJVbenHfC86E3+y8/u8xebSgTVmoPi0+WuyTdbb9TykAvvT5ZlyMaBBDjh9bhLZQnS4F8pbLw8R7xz4tTvofAxI4qRg5MKQkmjHT0XOdvqac7YzTmfgKEXF83e7b5LiIDdtjgnU2LN+jalH2q0jXKDqEusPZLXV1oq7gb6mVCYTUpk2OHXcUJL0zC9H+D1e5mCccq/wtEuaqUBy53JGbCPzJE6gWCAXefJ/7GiidwUgkBof0Ezl3i8SaUtMoNDG62HZTPEO1T9xKejWLz5GRQ7ClI9fS0jtarxqHo63H+L0PvctOpEuvyQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88025a9-cb4f-437a-3111-08de8f47b7c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 17:05:32.0972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Rw7/o3hk0rAv4DgrhWRd3h/g8tLTC4CExsLaw3u2kdEZInOiIkUN0noMM3imsLqinq9E4vchqRYEC/DN9cPtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8426
X-Proofpoint-GUID: vPQDY7ptR4x-9FcpjnFM1KTWz_rHZLnj
X-Authority-Analysis: v=2.4 cv=BqyQAIX5 c=1 sm=1 tr=0 ts=69cbfee0 cx=c_pps
 a=HyGa0dTC3wHuVH0UnibSIw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=07d9gI8wAAAA:8 a=ag1SF4gXAAAA:8
 a=Iosyt_U2ci9kkuHKjKIA:9 a=wPNLvfGTeEIA:10 a=IawgGOuG5U0WyFbmm1f5:22
 a=e2CUPOnPG4QKp8I52DXD:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: vPQDY7ptR4x-9FcpjnFM1KTWz_rHZLnj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE2MyBTYWx0ZWRfX9dHDiOpYJKeh
 xJZqHiOE8YHiDVZf3KUisBtpWZ6rQBPrgaoSrCw0noILfA0Jrzc6EByE+u3Owmbx8RFwuAeezQ1
 JJrIHLpfcGo5Fg41RZk+1a0fyKML6EFvCV4pM1wix7UTNy5rekyNNNNVg5DOsdp/SPlgsBJeKfR
 Bv4KUDKAOP3gfIq+eWZIRQ5oPN+BtsZoRCa4vsjqz9LfSVvUQAuK7k7lVZ9WLlQkcaX5W8U8pHV
 xSumkeB45UDLbrd4S8Z8E2F1mmh60dDMFj9SJl2BIW0VJHKWg6ib7AFi1VI7b19G0GDH9TWRNeo
 IjAC7Jn+9E/YdJNJsK0Rc1iIapJA3joOK/d579IJJd0Q/ZgeoEa0YX2+FL81QrOk7acihBgrZ8l
 c7q7NUm4HhnQ/qw9C6Smetddy9e33KSD3horb0z7fUALRHft6HKkrz4VCZn3QdjdJBEengDOJ51
 Q34wyiVHHfDoadhCIag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310163
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
	RCPT_COUNT_TWELVE(0.00)[25];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8449-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,metafoo.de,analog.com,kernel.org,baylibre.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 4A37C36E571
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Tuesday, March 31, 2026 11:59 AM
> To: Sabau, Radu bogdan <Radu.Sabau@analog.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>; Lars-Peter Clausen
> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> Jonathan Cameron <jic23@kernel.org>; David Lechner
> <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>; Andy
> Shevchenko <andy@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Uwe
> Kleine-K=F6nig <ukleinek@kernel.org>; Liam Girdwood <lgirdwood@gmail.com>=
;
> Mark Brown <broonie@kernel.org>; Linus Walleij <linusw@kernel.org>;
> Bartosz Golaszewski <brgl@kernel.org>; Philipp Zabel
> <p.zabel@pengutronix.de>; Jonathan Corbet <corbet@lwn.net>; Shuah Khan
> <skhan@linuxfoundation.org>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> pwm@vger.kernel.org; linux-gpio@vger.kernel.org; linux-doc@vger.kernel.or=
g
> Subject: Re: [PATCH v5 2/4] iio: adc: ad4691: add initial driver for AD46=
91
> family
>=20
> [External]
>=20
> On Tue, Mar 31, 2026 at 08:36:42AM +0000, Sabau, Radu bogdan wrote:
> > > -----Original Message-----
> > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Sent: Monday, March 30, 2026 8:24 PM
>=20
> ...
>=20
> > > > > > +#include <linux/bitfield.h>
> > > > > > +#include <linux/bitops.h>
> > > > > > +#include <linux/cleanup.h>
> > > > > > +#include <linux/delay.h>
> > > > > > +#include <linux/device.h>
> > > > >
> > > > > Hmm... Is it used? Or perhaps you need only
> > > > > dev_printk.h
> > > > > device/devres.h
> > > > > ?
> > >
> > > > I have checked this out and it seems device.h doesn't actually need
> > > > to be included anyway since spi.h directly includes device.h, and s=
ince
> > > > this is a SPI driver that's never going away, it's covered. Will dr=
op it!
> > >
> > > No, this is the wrong justification. IWYU principle is about exact
> > > match between what is used and included in a file (module). spi.h is
> > > not dev_*() provider and may not be considered for that.
> > >
> >
> > You are right, my justification was incorrect. Under IWYU, relying on
> > spi.h's transitive pull of device.h is not valid. However, I think devi=
ce.h
> > is still needed in this case since struct device is used directly in th=
e code
> > both as local variables and in the regmap callbacks.
>=20
> Really? I can't see that.
> (Hint: use of the data type and use of its pointer is a huge difference.)
>=20
> > Also dev_err_probe() is called directly and lives in device.h.
>=20
> No, as I started with my replies. The proper header that provides it is
> dev_printk.h.
>=20

Yep, my bad... device.h can be removed and devres and dev_printk be
used instead. Sorry for the confusion from my end, I thought I was
looking at device.h, but was instead looking at dev_printk.h.



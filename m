Return-Path: <linux-pwm+bounces-8203-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJo5ElvLqmlWXAEAu9opvQ
	(envelope-from <linux-pwm+bounces-8203-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 06 Mar 2026 13:40:59 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0EB220CFA
	for <lists+linux-pwm@lfdr.de>; Fri, 06 Mar 2026 13:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11DBC300B541
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2026 12:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEE0279324;
	Fri,  6 Mar 2026 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EtL0mWXC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98FA2701B8;
	Fri,  6 Mar 2026 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800795; cv=fail; b=bvZO9YDPeMbHJu8NRRRx7BPe8Cq7whNCYDpdXHedm5kiM+IrELaFUnSEEHa6YJfcw16hXoq0gdpiIbU0wHyw3UYMnkmb8iQfvj+E1wQcd4PslOU2wGIIjnUeW7vsTDfhwuRkN5XtSzZ8mzYIy5YbBUwu6RV8YyWV5F5nbHDwkNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800795; c=relaxed/simple;
	bh=XWug7yTDhRCAA13DdBsfjptk/9OAWSJlBTFZiRmoVQM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HmY0ZHqDwIv5t2SHdJz4LbtVfFDBrPNaZr3VPuXtQuhLG2PC7k7g8+bqRR0A1w40jarYyN4ERpWsw/vPNj2xH5ovhhomBQnhEJr7U04eQk2tuGK0Y4ddyyBVfqaivhS38QjeqKP0Oqn1FXNe7ovYr5REhQVrFKowrugGyNry9CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EtL0mWXC; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6266OaU32140227;
	Fri, 6 Mar 2026 07:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FEkBz
	Am7ZdWusFPK/DasjdGtQ+ZmE5+FofBqH0FKj+I=; b=EtL0mWXC7RxWlkVIiXMl3
	UQkT0VJAiYm3JSKIkCBoYD9Aj+8eHGijhiJZ8ypyGCFT6SGf190o3bekrvZYSFTa
	pWrVR8ydPQq72GJROC2HfF+a8bme5iUGGbYkv4owRaAKOTe7YPS+9+n2HkgkWeC/
	Za96CJ6tM4V7zYTzCeR2acRH4uG8qUVnOdUvwT7cEJEoqM3KCYLprdVJt5I7U2xQ
	+SxH1s0vdplBAKsG3SkaEcSEdOLSsKHm1mIK2nrSKW4KgGrvLl/bN00mSnz62hIU
	0ubc4WRtCDTTM63+hRHrZujWak9ZQZuIbU9GmAsKwleMtoAd8wHpAcvEjH1kDtY9
	w==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cpd6hkf01-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 07:39:33 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4HJzxaJviWf7o2/ij0F7XyrgNBxBfh+yiILJ99J12sEVjdq/aoKxB8d6YsGxi9+RYcLDpvpOOeIML+192fGQfIPlCYWpM784gu3LAj8U2cmupImSIQ9XcRAehTuuLp9x3Wf4f9puvhmOhv9S9u2FNrH0CwMY8Prj8aDBznVeKrlGJC4PPkBKZvaKfDSrmp6O7Obih/FW8uW5X5PYFRym53Crk56HR8pQud7Rw3fQglGsDeuLJ3dRS3ONj/3NAuQegnqnB5XO9m0Vs7VwzxWxYoRiZs/uzGi9SuVfw8cudvJf+l0crBd1a9knU5vE+rXoEhMItvq8IMd4nsrJ4tPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEkBzAm7ZdWusFPK/DasjdGtQ+ZmE5+FofBqH0FKj+I=;
 b=W9kIXXuA+TPvfckwNi7eWDUVBU81l3BkNKvZ/mO6KwSk85u414HiUi2aBfceVGtaPyoaFU8DEo+540iWyTeZDnO4GxSPp3MzjVS4vbb2ZVb+fDanlfzm89/s34yKKTwV6azfFiQVnfX7FYZuM8ax2uwg9W2xmmzfbxLiCOT0N89iX6n5PA1h5ILINWMmLqPJlFN7vsaVWKdN9j5kmH3O+JMjmu7Ll+wqZThtiRslScEfXFk58QHCmiVTm6xdn3hsT7h9ICiGeP91/N/FNWuuHCu0VDQzK/WiqVZ2IvNIu9PBtlMChhDni0pdOllCEdy1E6wnt2Jpfzvd1tHV7NNsVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SA6PR03MB7782.namprd03.prod.outlook.com (2603:10b6:806:444::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 12:39:30 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%5]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 12:39:30 +0000
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
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [PATCH 0/4] iio: adc: ad4691: add driver for AD4691 multichannel
 SAR ADC family
Thread-Topic: [PATCH 0/4] iio: adc: ad4691: add driver for AD4691 multichannel
 SAR ADC family
Thread-Index: AQHcrJrn376aKaRceEOc7gqoKaoNELWhafkAgAAHPEA=
Date: Fri, 6 Mar 2026 12:39:30 +0000
Message-ID:
 <LV9PR03MB84149EAE41DE73C61B81091FF77AA@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
 <aarDJicasFlUnOkx@ashevche-desk.local>
In-Reply-To: <aarDJicasFlUnOkx@ashevche-desk.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SA6PR03MB7782:EE_
x-ms-office365-filtering-correlation-id: 0b115e2d-dea4-4dc2-3249-08de7b7d699d
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 EGqZVddh7i0XTQldcdXdXas18XLqGKz8Rs6cPeE84SAOZvR3bYp8d9SXd/WjMYtuAAO8ZzWfpvrlR5mNJeCdDKNB+ie9GMCMGQ5n3gnWsJUpOLbRg2VCW1BeuVqxtfBM6nMByJ2inPhHnaF+gDInz/+vpVAKEqJjjm9l/b06njBBvVlIDhFcQ6TKrp3VIsehG/g4NW/CaMS3sKATNCJc63UHVBKDIutaPHsC3F7GQg1ZxRi3OormBC6QVw2Y8lkvvtQQLpc00f3S3BBBh3V6/Nl7L4QqvQakYgNER1uwgz5ywtU7Zl6il29R6B+7iGXFtYL7Rg8hm1n/xSz+rbn4dvqt64TmPB2C/86X1flspjHV4MBXwEwCIsugRcR4MvA8t3OnxvGayimtRv3y9VRqftUJlaqDkGDzZtLcy9O+d4OM2aDRSrboXtIvsyHkyRXNqfREaYtzr5WFbiT1GW3zKGRA9UAIFCVV46U0w8bJN0RXCpYXoNCJozTirDtfZHx5dPOoJyJK4kLpQ4Ac47dInk5muObBa8qqFXQaTKNUbwogHUY8kIuw9hEFh6jDbhEeoU95sLKWIS6hEcEvwnLyIZr64TmnRh/X5vIMASb8IYIESv49sab5b6g7aFUjVbMpjgjgFk9Kfp6a3PExwN2nUrW4DrSBja3RdHI5dmMZyzkjoqvqUZ9jfHVwuWIbA0bYBbPXzvkYJ7yeAQyXQ4IOSSNOe9sbyO53V1Rgrw6zHFyCIrq/oohtHzGxzUKC2LOn+I3dTkq4En1w1ew94lTXkNWD7L/6o35FOh8kF9wMatE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2QNNw+1m+IzmDiQxoKjDEwEerpLFSfsL3JHYY8Jx1//W2BfNuIV9Zt/7Ej?=
 =?iso-8859-1?Q?UiMWyLIk+sqm/+4kopnyzZvEX3oDnu9+FnXhxIhPPvSfjSvipCn/6X2dri?=
 =?iso-8859-1?Q?+hX14nmRFPdej+WDQzU0Va4mVoxoiHs1GvogsxOhHo9Hvi2L+4PKDJGPEI?=
 =?iso-8859-1?Q?VW7ooF0zv/6gKr07FWaj8sgEYz6t9tFsjdG/mbFAb/jMJ7bmjJJic1dPpk?=
 =?iso-8859-1?Q?1lcmCogQvYJiQmQX852V/2biUtYU9B3TE2YmKTXzorXoGl4RJqQiM0h/MG?=
 =?iso-8859-1?Q?YB57fWlYvSOHCsBbv+e+AXUD4qbstzWymXNjJLxjPDaJY7HMTyXwpi0nBQ?=
 =?iso-8859-1?Q?7nwMOK7zaADWXjtiWPwT+b9e3qbFznocubXwJBlL+vwenC92TwrmyY4UDX?=
 =?iso-8859-1?Q?U962Xzd8quW985YqRICYH/fqz0VbCAsAy9pk72vDXRA/wf6GpghTKNahxf?=
 =?iso-8859-1?Q?DTjloQ8T0eLH43JbKmWxl8KRodD1YmXsktM4KhtCHt05Lxm77aGTlPIoHQ?=
 =?iso-8859-1?Q?ih5RIj8q+a4PbFJTs2piZ0JmiGxI4Tpd2TpwvBzAv/NOdOJ+XW6uOIbjPe?=
 =?iso-8859-1?Q?BZ/1QH8qlcz1AKSj2xfBQ+cq4FBUecq2c6xye4SssgiHF7UhiZPTDHjDec?=
 =?iso-8859-1?Q?d5R3MIEhxXWBm+R/lB993RZ15GQ00L1qF8mV9hDtjxD8CEo9+1y3kIKrvY?=
 =?iso-8859-1?Q?ZfwwK10OErmutfbhvuc4XuVMdlPyQTgnLuNIMjO2ZfOhbVeCfJwQLoDxGl?=
 =?iso-8859-1?Q?jwnHLdPJbWgXGKCH+bqU4cgj1Yz9do30u+r/mBycvU9aJWOVa6K86Mq1BL?=
 =?iso-8859-1?Q?jgRc4r/9XojsbHKU5YhSf1eclAJxXp5+l3jo7T57pc1ewF1mqXysc/L8Jv?=
 =?iso-8859-1?Q?wTz4/nMEwqM1umce9kr7NYvdCVxBRKDqi3LbTkCY5OCaxO5t0ANIutHUiY?=
 =?iso-8859-1?Q?f8X1zrFmBwaRrQMOO+gK7c9S94ogFP47S8tMqyYfjuoziNsOTlHDAu4+64?=
 =?iso-8859-1?Q?hAFNAmlEUb+m6oA41UT+jcM5uYqc6815X9tVqIy3C0hREp8o7s6Oja41uC?=
 =?iso-8859-1?Q?GyOiuze8Srbb/pM+64a51raavjZ/ufURa6qfAaXlZ1GHi76g4XY4FB//br?=
 =?iso-8859-1?Q?B1imkhbd2M7OtvRAhGko+Cxc16OoQGIcEnjXVxdf/opf39vOcXlmtQaMyq?=
 =?iso-8859-1?Q?HiR4D5c+4hkqubIcQpo5Qmz3qC7a+uE25vHwPs64dCzlGxAZFcMHXpnjRN?=
 =?iso-8859-1?Q?/7M4rfBioLlCwebXWeymxRJtSbKS2DBC92ACmkkp05I2M9kHBL0G6cW06I?=
 =?iso-8859-1?Q?8Des6HJo1Oyj3/K144YITdwe2f0fp4r5mV2uY7iY2j81068E5kP2VVUsYa?=
 =?iso-8859-1?Q?umREusrjKyMnGL+f5Lvp84XkAIhday+OHsNp56CyXGS5lkTBvW3LtQHagu?=
 =?iso-8859-1?Q?YV0Uq4Avawwb30vQ8E5X9mmNwrP/+WA9XMsdZQse0Qx0KPPAsTFJweDylL?=
 =?iso-8859-1?Q?oI4f6Fj0ITCX9dyl38UDYzD3ccAd2Yd8203dwbQA1FEkhLYT1BB5d1ycd0?=
 =?iso-8859-1?Q?DRUR8KJGXDUbkzaSzEXLRIGVCoL/ZzOf5H4oHCSdf9Fp4wP0MvfsI1XvvE?=
 =?iso-8859-1?Q?JjO32Q6SyOYM8Rs5K6zfJIz0bEK6ybjdMNST4cY/fcv882OYqtJqS3UwV2?=
 =?iso-8859-1?Q?HLB7Kv+G6qc/ZJeOHDq3g6pm0jzWAhTEjhr4fE+DM8d2+GKQaxoZCZ5Bf4?=
 =?iso-8859-1?Q?pZ+oCNVG2QXRtRZ1YygvguDUDAVNAxskCAhFuUsxF7lDiw439ldwDYvYvA?=
 =?iso-8859-1?Q?mdh1r7Z8Xw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	XT51fJtIEyB/gEK+nGS7+Zue2Lzhn6SCh8TUxBwjkpnxLF3hc0RTW9wx6L3hr8+XYbdK1WzzRfNWdDxO96h+LKLi8gVb97NN7Ni1xsc5bcqtawuhKsGzjv1qa7Ijpof4LTkFtjorGrioob6xsT7CdzRMpla7xzh2e1x8OSDsSRaR7iqHjVetK9LwqsQM0+jq2TzJnq2xQXB/c6feBdj49CtwRHGrLfRaZEpTym4wKnO4iONk6KKNo7ldNEJwGpbdeOF26QFZIetbMbOK5eyb9XCZF4bbhe0L+MZMd2JqgwWvZKzl/ntdJP0iiSycwgDLdHaI1uLjwhfouB5j+QjV0w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b115e2d-dea4-4dc2-3249-08de7b7d699d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 12:39:30.6012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YupVOJ5OFpiqK+mkvKe/eBlYF9ymkTuS7WRYlZbshemjEa6UVtROfDDL9TNDYtf+qNghVwr61M4n/SjVNIhzhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7782
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEyMSBTYWx0ZWRfX8uaurK6Lgh6H
 1cHhqTMeVL8EK83dUQICl9bIcc7u/x8I6PvOd29CNzICdFd9+cjF2YGAI233N9gfld7ikJ7kwJk
 qVTum/g+HTMoO04LnFgS+dx7u9IuoJeLoSyLga5v9OMcTTsJewShdi8wae81dpoR357f/ERyhW+
 WT1SjYu968tgl7CF0hdOLI9Xi9fCpEQrm+VR74mNR7UJocssEwhra/G4x40ClGj+AvH+oXNJ7M3
 6bkA7j0fUyzRDr/5wgY3kTbpEdHNfFhEY6IO8u7JjIEfg8mxUvwQIb7+iluVfPHci3rvnAPOkU0
 1FUIktigBbLL0iWFTB26sAfgletlOGYpiwt3xHANOnJx9VnTAk6fKpjp9EFgP5+L9/sklCl4pw9
 curkN3VKIiJJS/OQ6pv/KFzpSHupj2x5L6oWiiKwSp7H3vC86Aw8H+NR3W9hhqZFnko7tsSHvI+
 XbvjNG/mK6Vl1MKVgSw==
X-Proofpoint-ORIG-GUID: tbWmGruROAHwnq7Hxlzr48C5bsxOCQqT
X-Proofpoint-GUID: tbWmGruROAHwnq7Hxlzr48C5bsxOCQqT
X-Authority-Analysis: v=2.4 cv=Jtz8bc4C c=1 sm=1 tr=0 ts=69aacb05 cx=c_pps
 a=CD2IJdD5qp8L8UJuiUkm2w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=IpJZQVW2AAAA:8 a=pGLkceISAAAA:8 a=bn1LqWbYnVC-s5rXbvgA:9 a=wPNLvfGTeEIA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060121
X-Rspamd-Queue-Id: AA0EB220CFA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8203-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Friday, March 6, 2026 2:06 PM
> To: Sabau, Radu bogdan <Radu.Sabau@analog.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Hennerich, Michael <Michael.Hen=
nerich@analog.com>; Jonathan Cameron
> <jic23@kernel.org>; David Lechner <dlechner@baylibre.com>; Sa, Nuno <Nuno=
.Sa@analog.com>; Andy Shevchenko
> <andy@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <kr=
zk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> Uwe Kleine-K=F6nig <ukleinek@kernel.org>; Liam Girdwood <lgirdwood@gmail.=
com>; Mark Brown <broonie@kernel.org>; Linus Walleij
> <linusw@kernel.org>; Bartosz Golaszewski <brgl@kernel.org>; linux-iio@vge=
r.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-pwm@vger.kernel.org; linux-gpio@vger.kernel=
.org
> Subject: Re: [PATCH 0/4] iio: adc: ad4691: add driver for AD4691 multicha=
nnel SAR ADC family
>=20
> [External]
>=20
> On Thu, Mar 05, 2026 at 02:23:26PM +0200, Radu Sabau via B4 Relay wrote:
> > This series adds support for the Analog Devices AD4691 family of
> > high-speed, low-power multichannel successive approximation register
> > (SAR) ADCs with an SPI-compatible serial interface.
> >
> > The family includes:
> >   - AD4691: 16-channel, 500 kSPS
> >   - AD4692: 16-channel, 1 MSPS
> >   - AD4693: 8-channel, 500 kSPS
> >   - AD4694: 8-channel, 1 MSPS
> >
> > The devices support five operating modes:
> >   - CNV Clock Mode:    external PWM drives CNV, samples at PWM rate
> >   - CNV Burst Mode:    PWM triggers bursts, internal oscillator drives
> >                        conversions within each burst
> >   - Autonomous Mode:   internal oscillator drives conversions,
> >                        software starts/stops via register write
> >   - SPI Burst Mode:    similar to Autonomous Mode but optimised for
> >                        SPI burst reads
> >   - Manual Mode:       CNV tied to SPI CS; each SPI transfer triggers
> >                        a conversion and returns the previous result
> >                        (pipelined);
>=20
> This cover letter doesn't answer to the first important question: Why a b=
rand
> new driver? Do your homework and check what is already in the kernel and
> explain in the next version why no other existing driver can be reused (r=
efactored).
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

Hi Andy,

Indeed at first glance I thought about adding support for these parts in th=
e existing
AD4965 driver. The registers indeed are a bit similar between them, but the
channel specific registers are completely different, and more than this the
conversion modes are different.
With this being said, I will try and make things more clear by answering th=
is
question in the cover letter of the next patch. Thank you for pointing this=
 out.

Best Regards,
Radu



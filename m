Return-Path: <linux-pwm+bounces-9081-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Le5JG5AEGrzVAYAu9opvQ
	(envelope-from <linux-pwm+bounces-9081-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 13:39:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F985B320D
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 13:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 032EE30120D0
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 11:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CA53E6DC3;
	Fri, 22 May 2026 11:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AY2eMMAi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1003D4123;
	Fri, 22 May 2026 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449959; cv=fail; b=GbV85ksI3otVIVFjjFSJEc1DyftiERTjpBMe2Is1aHbLlruo3HH6TM6AwyRiefB3lq7iPFDnwYWqfYDhUmdYrXSlGF61SC0RQximMFhp0oUYTAWtzCMKtDM/R9dzc17qY/Q8O6JVfH0rNWAJNhIOy804bLfKsbFCgRbD1fB9um4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449959; c=relaxed/simple;
	bh=QjHRE821u5afXVuxjm5qO5WYUHB90pWZ5Zk+gVgeVGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e/t8om8EKucoFG9mQPMpEMDy3/Zs6sEEU9m0vQOo1aEg8w0JGGQ4tr7IUeM64mzoLnHxGkZArpuPjs/WqgXBZGujXZ0pCVKy1X6aIX89pmZ2j1mm7ZOJWqyrORg8o9PyEFTWv5gsj5pKtJI4sTh0kJX+SiY7ktyfIQD073/kITw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AY2eMMAi; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MA4RBN1374611;
	Fri, 22 May 2026 07:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=kS/Ir
	zD2GDilWJgBL/+z7baQNQ8EpiO0wmLs+ep26Lw=; b=AY2eMMAiuY0lFr2Nrc5NS
	2KNI7Low4tI37H+TQRvGbXwRbgzw7ySh09H6OywtO8f7fhHQGhpQxzDI9jpxdA1F
	J9j73I5Qw3tLDAbFuDWqz/sfAUM8qaS7pJFZGdNsmctATVt5zloJSb0f8AqmS4JY
	32MWe2md8CQj/kBbw4i2uwhQxmeV5fRzjPAdG9kh+0CvZisCe49lyW3UiTl0Tv+f
	awDUMdTJkErat7Y3ihaGMehikq5bET9unZW7n8y14qsE1Y/VTeVfsxWzlbC2YAEC
	6Uzp6HSzWOl8zydMyn2JK/XWGF7p1NLlpjvafQgb9KxO0OSlsCoMvEtv+nGwBoMy
	g==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013005.outbound.protection.outlook.com [40.107.201.5])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ean2t88fc-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 07:38:59 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBij2uNrpEuXHaIKA483tWnnhE39DMA/lR+zn7x5Q17h/2Gf0l0Ay1KQqMp8Kv1RwfDyx1SBSqyE+6/+VUlba2SnURKIjY9+yP0Zf22YoEYvVBrM1XZP0w6404YKLzp1Og6VULyxZZNppf/4r0P74UpW8lAHSCKiwhpT426HsBMWrNjtyJl6bM1lGz+NwwfWbvpypIVc3ooXOIwkEoabEsCeVmsHHHl41sFgaZw0I22AiXIj11aIOpF4iIIfkmchT/1fyJ8a7qgHLSwNSbsib24oV2EW2sA6glSOxvL6vf0lqDXN0Wl+i7dJrZgdYEdHeV07RhaiOAPG360kFxUosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS/IrzD2GDilWJgBL/+z7baQNQ8EpiO0wmLs+ep26Lw=;
 b=bqCLTwBkrUfqtSnOTW1S6jmivAUy2DKLNCKZrAtB885UIUS9tOWMzg4wyn7e9hRKbRbo2pbF1g4qJwxbpuFQT9JR3eRLSfEmyO3CpQ4yiX2APpjB90bzI++hO8d7jtNwhAVcDLw3CxGM0x0hpFn6o42NZXJjEC9jBHLFWhqY/KzOAxGnVZQ2s+XHQeoUcuQzFGon8EvETVtumeSIRbIFdBFEwhH30iTrIV6kQEudTvWfN1k8KrgNAXL/x4y57vu8DbQqVMr9xbjdNLSbPzpVY/Nl/SkeYqYtVFWqz5zF2+e2gnYFCI+bIsq6LUxsk1J1yceyrcbkrKYOZS3THeKIlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by BN5PR03MB8078.namprd03.prod.outlook.com (2603:10b6:408:2ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 11:38:55 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.21.0048.016; Fri, 22 May 2026
 11:38:55 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
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
Subject: RE: [PATCH v12 5/6] iio: adc: ad4691: add oversampling support
Thread-Topic: [PATCH v12 5/6] iio: adc: ad4691: add oversampling support
Thread-Index: AQHc54ntIELVSeZPQkGQQYBIis0q2LYYUh3AgAGXrQCAAAK40A==
Date: Fri, 22 May 2026 11:38:55 +0000
Message-ID:
 <LV9PR03MB8414E63DA5C2C22A46E98215F70F2@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260519-ad4692-multichannel-sar-adc-driver-v12-0-5b335162aa51@analog.com>
	<20260519-ad4692-multichannel-sar-adc-driver-v12-5-5b335162aa51@analog.com>
	<LV9PR03MB8414CA3DB26235605C9323E5F70E2@LV9PR03MB8414.namprd03.prod.outlook.com>
 <20260522121628.21bf03f9@jic23-huawei>
In-Reply-To: <20260522121628.21bf03f9@jic23-huawei>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|BN5PR03MB8078:EE_
x-ms-office365-filtering-correlation-id: 044fdc0a-a404-4c66-509c-08deb7f6b4ee
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|11063799006|6133799003|4143699003|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 VGyMIRYV4INF3h2EiGyG8YWmTiKt5mM8J1PwBo3GuwaPg4BNgm8O3sWs+015Z5EELIKIZZn68hUoa0UhJbxE6n4PC+awiNs5ODvn7BW+VxO3yqEhOMrmZRfiYLZ4+T96Tw6i49Bnd/BQ341ua+66opJNAadVwBgESQ+RPhVVWhtFlZ2WqBlsXzh1v0DvPgc6C+9ykVHGUl3+DLRq9yqk1+QhdhGcpWtw9chogY+5ThN1Bgs97W4jlT8G/wdVyPTt+AD0ZoSyPL1CS3fh5awHVfqg6/vElhsKIuYIwu18C0s2QtmwagRiQq5tTuFWQRR4VwD9wkBM/57AYD33s0M3sgLP4W5huwdIXRoppf6mJtAJsTvF+BqlJV90CsIY7Jx9SbEgtaFI0ni2k16QHYwA5HSvZgSzM9iXsyL9CVNv/CB96NGwPYMPDyjeY5Pjyqgsbth5zRXyR/Yk+lWSZC9ZfOhflvoBsR5Q8BQx/Vudd+H/cwz4awlE0i8E7gl2napD0d2fXSYyNdz/oJlKvlaP4tOkwnKqu0Veld1C3ygMIpAkTK9SVnm8yR0YkfB3MWhFDrfcOxVtW3J4a00hK/fKGlQxPDJxZo3btAS4hZcG02eK0DSBJgHc+6fj7BM9ZwJK5qeaawzRMoMCb0C4HbsMst9jHtVxbFv5KtDF7GHOLeMFD9QsvG+Vq232Dh+lOxzj6Rswh4HboSWbyEgzcTMxwFLHQp/LfrSCEInIto83OSw6XcKivQZd9W9mTuSZQKaR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(11063799006)(6133799003)(4143699003)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mO/JRqg54+70IktNO0o3MAGWCd0rfVAWlUDgqNb+8t8pNeuDvlXsV4l8zu?=
 =?iso-8859-1?Q?01cHXSBlqL5kU6NIZsNIiMGKrOsNwPaOjPFbfw3uoEpzoIs/3F4cxqvz/k?=
 =?iso-8859-1?Q?ybXsG/MqvzHGASLTIXEmUyJ4SWSzOhbOrEV8cv8XeZzScVUwlkJOzMWVXz?=
 =?iso-8859-1?Q?HHqzxEdzW9s+wEeOFvYAMWOkBmFleaImpXI6dJTOVH6qZ8fLKbAk/HaUzk?=
 =?iso-8859-1?Q?HLNHGst7nbcqe+c6EmJ13xcq8MZ8UAbIsOTxi8YNinvwS2raVExO0Omvnz?=
 =?iso-8859-1?Q?gAkxCeGEBie4PEpbsA+o4thr9KsARwo/Xzt+iS68rFPJ1uMjAWh7u7D05G?=
 =?iso-8859-1?Q?u0CM5OzV0mokPFjpph9znZI2BORAJ5MlPyoPyssKp3lOobOvGpo4Rzq7IQ?=
 =?iso-8859-1?Q?PXFEm0dNm//hGJQoLwS2AxTfIZN/qEseWgF+IhPqjJdobUH3/xifLypCQK?=
 =?iso-8859-1?Q?M2JnqjHbTD8BkJch5TvmFwrYUFX42bBoGS54zyC/pDhuhCUIx1FiIBoQvV?=
 =?iso-8859-1?Q?k11b4moeZFn44zxPg+C3PD1HbocH4Dcq+fWc4cZ0ja96aUgE6auvpVeQb4?=
 =?iso-8859-1?Q?PnlQm4u0Uul5sT+HgtMGXsfKB/rZtshuo4k1BWeUZTm0XJ0WDT7sHr6dy2?=
 =?iso-8859-1?Q?zZmCEPjc7ECNtuRYCEKTeQliHunCAK1nvlC9awV7cY+Itp+tORGyik1XMo?=
 =?iso-8859-1?Q?LNPMnaFJZ2OjEprffHP1BKp9//RIxnBDPdfIic3OW0c/8BVIsSqN3gp92b?=
 =?iso-8859-1?Q?8GxJw0eyOVeNCvkiPP0q0i3o/oo5MiVoW1Ba6AFUbqJ548m/UQSgBrI1O0?=
 =?iso-8859-1?Q?uYakDLxLY4rRAWRl879eHlqxSwUB0KNfdmc2qEMPfXnvThoog84/K7+SQL?=
 =?iso-8859-1?Q?/z8kB8xMcl4dW5img3K3ipubEiLGPYbDjzuMnLguNJui58U1/u2OLezyeA?=
 =?iso-8859-1?Q?GdUoKpwueR6NMmxfe6IBVxJbFDpyrhuXjOTKuwLAYOynHXZnDTqsp/HBtv?=
 =?iso-8859-1?Q?n8bq7ZaiUgC/a6q+sNmJGfAbvJ9mgZ/uNcOCAAJ6Q1Hxu+Ne7BNY3ljkNi?=
 =?iso-8859-1?Q?8fNRi2DFPCfb6zYkXS92M+Td6NweE6aQPhSh8jwEQL8XQmP3Me6yaYJUqt?=
 =?iso-8859-1?Q?9W5dFKesv96woEZ/8tXujSyKPuq4pZfWHLZPfigge+++a0UpIaw8Su+tPN?=
 =?iso-8859-1?Q?q6UjczDLV89+OhPi60uZfuKt+TOnlo3cObnb5Gftq3iDYu5U+OJcUc6J2I?=
 =?iso-8859-1?Q?Z3qu4zdrONT+8riN1CwvDtMJNks9sVdlT3VUT3FSE6v4w5qdZLkBgxef3F?=
 =?iso-8859-1?Q?sjbtqtUsZNOQle90H2WCq5bOTWIrnexVBvmAUcXFZCX0TCfQ0tEiEZ35la?=
 =?iso-8859-1?Q?F8h6yqjXjyxMNaYyns+yggr8HpuytfxLEzAdi392D0mOonIcUg1H0rCHvY?=
 =?iso-8859-1?Q?PBv/HgB3VbyZERhvxLLo0AMbENRcVpFywV2UPECm4AKe5Dw8+nCU8hFAgu?=
 =?iso-8859-1?Q?UMdzcuNYzngKgBtuJuUrlHYK7ALw+FORyXvLcu8xMi6gQWB52Z35j5YjP1?=
 =?iso-8859-1?Q?EyKQQxaVTAxD0xYbPPCdlRshoKZhcBhm5khnj5kFopaiU8dH2Rg5TesjHg?=
 =?iso-8859-1?Q?C6EVDvDkUK7P8i7Uy+fQ57qyy5UHlERJgE2PvQ8hhRU3+hyPsGuMDP9bew?=
 =?iso-8859-1?Q?VIy51TehlBbj3IzbdiA8+sfVPf+R0nH4cRiGV0Z+BZU05sQsU/HM1Z3S+b?=
 =?iso-8859-1?Q?+HpQTQhfggbGPO2ZFTSGqLJ3+Q1lsNMlzLhe61eA9YmG+c6zNiXgzowmNA?=
 =?iso-8859-1?Q?Rye+BLqBhA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	UJwyqg4f+73MXh2mErKTkU6EHgkyBH5EXI6l6YiNeRWC7Ux5y43nXNsQRVz3UhY9rEQZ71ydodCSXKxmtQQXJ5uopcMIO90jpzcuq03ve6QFDtdXtVU9vMc+Ke0JdtFx5GgCPMGe3hWZMhr9b7rALkf2KKSOh5BOmgWbq0OflnjjBTOaRONwxCz+VTtPeAj7mDQwgTyzOi3xGix1CqMhYQryXQ7xCPl9LMsstsd6y4pdFJMvVuNtKs446c2ByvE64hT7rj2KE0JCjK1PZjloIE2uZX44TGqOaNAeN9I/SmPzfZMw7VzMYOX9gbrNMbfjeDhUxu3LnGpr/jbnhOXHvA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044fdc0a-a404-4c66-509c-08deb7f6b4ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 11:38:55.8340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NLWmi6Examw7+sR1QcZxCzvPEU20eNO1VSEG3va81/pIsisSUumKLeZV9UKfSlVVnIepX7dnuFiGa/jVkzlY/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR03MB8078
X-Authority-Analysis: v=2.4 cv=PqOjqQM3 c=1 sm=1 tr=0 ts=6a104053 cx=c_pps
 a=RM5EPw/H4l4S9ahloXzS7w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=VwQbUJbxAAAA:8 a=QTTbG-3WGph0IW84D1oA:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: LwzsGhcBul_zKycduggZSzOvcEa3qh_e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDExNSBTYWx0ZWRfXyDSEve2pLYY+
 p9JlkXtGhnW8ZrJA8xLIPdQmvEaffJZfab85nfxZ+39+XlvzhZ7RRqD2S4QO6Umf2dUyWSHYV3j
 2nsZPHjbDccj76HF29f+mpPbNCiwgG78IYIiokDxBDhVS883Lw5D9pcHuGiOSGiVXfU3PzW3hBX
 nUhC61kGOygFmKSsg+wWAKyzlGF/R8gZ/Ykng+GyaMquXXWO6BbzpJOTP9C8F6/4jo0v7TXobqX
 DGdMNPmKaNmZh3G5BHVoU1ZK9IBgruNQ7cRJ78zg+XtO7QBLNh4wmFRRR7NmRiRHyLN+vUxDE/X
 hMH9ymyzPj8ItZrvWG68jp+v6M1ueK4eUbiRN+Tq5P/hCOoJdmgXHcTpD18ogkpFpR5MKDtmDfW
 JkSBA9rXv9A9a5RO71Pv4YruVbCvAMvAUiNdzZgG4o/XDwoDpL2HPYUgZonXOG7D/PgCGFFZby5
 REAsWnA7+VVuXZTWUqw==
X-Proofpoint-ORIG-GUID: LwzsGhcBul_zKycduggZSzOvcEa3qh_e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220115
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
	RCPT_COUNT_TWELVE(0.00)[23];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9081-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 56F985B320D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Friday, May 22, 2026 2:16 PM

...

> > >
> > > +	iio_for_each_active_channel(indio_dev, bit) {
> > > +		ret =3D regmap_write(st->regmap,
> > > AD4691_ACC_DEPTH_IN(bit), st->osr[bit]);
> >
> > Unfortunately enough, I think a v13 will come, too...
> >
> > Had a look again on what Sashiko had to say, and seeing the sampling
> frequency
> > shared_by_all comment again made me have a deeper look see how the
> code could
> > be commented so he wouldn't complain about this anymore, and...
> >
> > Perhaps he is a bit right after all. I found a section stating that in =
standard
> > sequencer mode (which the driver uses right now), all the channels actu=
ally
> use
> > the ACC_DEPTH_IN0 for osr, and so changing ACC_DEPTH_INn for other
> channels
> > doesn't really do much. And so I tested this selecting both voltage0 an=
d
> voltage1
> > for sampling with osr4 for voltage0 and osr1 for voltage1 and with a 10=
0kHz
> osc freq
> > indeed DR fell after approximately 80us which points out both channels =
were
> actually
> > using OSR of 4. Perhaps the OSR should be shared by all and therefore t=
he
> > sampling frequency would also be shared by all, right?
>=20
> I kind of lost track on the modes. What are the chances we later move to =
or
> add
> support for a mode where the different OSRs do matter?  If that's a possi=
bility
> we should avoid ABI change by allowing for it from the start.
>=20
> Then if we are in this mode, they'll have separate controls but change an=
y,
> changes
> them all, if we are in a different mode that connection breaks.
> If that's the case, just throw in a comment saying something to the effec=
t this
> may change.
>=20
> It's not wrong ABI to do this, it's just less intuitive for users which i=
s why
> we prefer the shared_by stuff where there isn't a disadvantage.  That is =
at
> most
> a hint to what actually happens.   A simple example is where different
> channels have one OSR field but they aren't the same - i.e. channel 1 is =
twice
> the OSR of channel 2.  Hence we can't share the attribute but any change
> effects
> both.
>=20

Hi Jonathan,

I don't think a mode where different OSR will matter will be added in the f=
uture. Better
yet, this advanced sequencer functionality is not really mode dependent and=
 is actually
something that allows you to manually rearrange channels and samples in the
sequence, and unless this functionality is active (it is not by default nor=
 is it used by
the driver, since we use the standard sequencer).

Personally, I don't see any reason to have this advanced sequencer stuff im=
plemented
since DR is only falling at the end of the sequence no matter if it is stan=
dard config or not,
the only "disadvantage" to say so is that the standard sequencer uses the s=
ame OSR field
for all channels. But that advanced sequencer stuff would only complicate t=
he buffer
enable/disable functions even more, which I don't think it's worth the effo=
rt.

So, with this in mind. Letting the driver use standard sequencer would ulti=
mately mean
that the osr would be the same for all the channels, and then effective rat=
e the same for
all channels, which I suggest having it like that from initial driver patch=
 to the end, so no
ABI change mid-patch series. This change will simplify the driver.

Radu


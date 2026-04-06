Return-Path: <linux-pwm+bounces-8483-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIpKKQV802koigcAu9opvQ
	(envelope-from <linux-pwm+bounces-8483-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 11:25:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ED03A29F4
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 11:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1915B3014411
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2026 09:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3985320A37;
	Mon,  6 Apr 2026 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kXEgohGN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D2031353B;
	Mon,  6 Apr 2026 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775467367; cv=fail; b=CGcPNE0aUX27aN/6JURI17xEW3z7zha2flXebkNNo5lEL2d2hrNJqptxjLrrrfD/NrouxzmzR5ryxqv4L4NF1TfqG9W7em4OaKyf30jOfoSRQLs9eayqrQHL6MlAdbAnSK5uYM3IxTkW5ugmw9bd2CWzmrmsEXZ5AkJAJWjvrIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775467367; c=relaxed/simple;
	bh=SBBBLweXIatElSPbs8BwN9Aqt81nzX9EZGvxhWf8MMc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pr+VuEVy+j2K9pr5JOLnrMnWSfbWFOHZ63glSqf9jXW5lHHcGsiwD8v9dWCox1mq1rDD051WkZWuJ+0dvbGDl3LbIWSZtKYHso2KJ+SDMmX+IOCfOPgf3vlw+PoYjOSF+PbGRzu6DG7DDhJJ+iPuQNsf/OB37Tt0RE3ZYdvyDgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kXEgohGN; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6368pGlZ2942919;
	Mon, 6 Apr 2026 05:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SBBBL
	weXIatElSPbs8BwN9Aqt81nzX9EZGvxhWf8MMc=; b=kXEgohGNWTbGVO41jljwp
	8C8qmfQhOEsRptOUkvgyJqUhRoXEdT4U0KSgRLEmAOYXUNIzprbUdJ0pfCN8OgGN
	5zCDmw2b4fArWlp1V2YTH/xvI/7dlGMR8DYDljXAijJHwJ98WwH413cTm3RYvrLa
	bev1b855lJLHkTZBR4wTcOKyD9wWmH4NRcwUcHef4DLjSTtyrM86cbbILMwg+lbP
	q9Vt6lI5+dHxOKpvUK8MAC0l5sq9CcWvQiI2HGWXz3Jz4rMe4KjIE8c74AanV+Vs
	WjFAgX+vbTkJVFeVDxEvNE0e6QibQhhG7QklwmYKO++p8wZLy9T6XoktYYEadCfd
	A==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013006.outbound.protection.outlook.com [40.107.201.6])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dbk8ebvsd-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 05:22:26 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qt5Nccaxiir6eUqypgkkxxI55L/XKwXJLHtde4wwSmGV0uCuIiyBJi6hzKmgUPm62/zlreTh3ff+BWjem6rYhnwFyHYaE1FbXduRcY0HfHWSClVzSLCATuXyCwwc+9/gsIYeyeTbU0Y1PGvx+pquKiV7Qv9cQ+t6rvw9dJ2lrxuz67Nb6W6ARqe0XpPLoRzQt96NzdYEnbrqm4UfhoCdo8BHKLu3wgUzxeajdwWNIoE9KdzVpRaEeooABXVR05aqveoOQJPecoUvNLKq7SKvlZFylOCsy0hvUboVejs3DXsN9skn1qc+LywZFgWo0kNGQd7J2VabDon/A0R9FTpUSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBBBLweXIatElSPbs8BwN9Aqt81nzX9EZGvxhWf8MMc=;
 b=PvGlT77qgV17j9BW/I1jl6/ktPPB/JuAsDOraGEQRIGCvdfVYKYx19WYACqxqhJXSBmdLrrLw2OIMngQrbn2xhRAGNmc7YbMpULUDDqrP9B7tza6Fll51JfkxC1UXf4oniKkj0Oyl3YAHNCG0HDKDbIKZPh+GFl2HharpfRRZzXrtzVrdgKy+o+GXsaPOjrjFgATV0y1FC06iLnf+xtetMGzGAKDzK6bXBIeJqCkTxB3qAlWMozWpW8CKcf8AV0b52biL8x+QTkxEDdgb+PQbO4CBv7anuwxLhMxzVcK3x2gpizq4QReijKWWWDX054JzGSZ3hlvR1dUpuRq72LAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by CY3PR03MB8152.namprd03.prod.outlook.com (2603:10b6:930:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 6 Apr
 2026 09:22:23 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 09:22:23 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Linus Walleij
	<linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan
	<skhan@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v6 3/4] iio: adc: ad4691: add triggered buffer support
Thread-Topic: [PATCH v6 3/4] iio: adc: ad4691: add triggered buffer support
Thread-Index: AQHcw1l5RJx3C9pl+keit6SmoV/BO7XPBBYAgALA7hA=
Date: Mon, 6 Apr 2026 09:22:23 +0000
Message-ID:
 <LV9PR03MB84143905DD2E10BAC2151EEFF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
 <20260403-ad4692-multichannel-sar-adc-driver-v6-3-fa2a01a57c4e@analog.com>
 <e38e5b97-e90f-4613-a15e-6c3d08cd77f7@baylibre.com>
In-Reply-To: <e38e5b97-e90f-4613-a15e-6c3d08cd77f7@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|CY3PR03MB8152:EE_
x-ms-office365-filtering-correlation-id: cf24cd9f-64bd-47b3-3eab-08de93be02be
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700021|921020|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 evCawTw92JjjXrP6CCnKjopZQNcetxi/c78reJ0UpX0MpqiepyDwT+drfTNELijhglxw4S5OenNoDOHA4+p1QeUmTh2fK7tu3OwrguEVbKyePlpG/EbfNyrlPaC8UvVkAbfQ2QRDQMFK8WRKkz4vYyS6Wx6FefVt8qUH6KktqUf6MoOlAmiDlujD7X/TpDJAARObNSz8pxhjV15oIQO1U0+yXkbNxnFVSEEWAfMUw46XGevC/cj7H6zYhcZrot4dxrTkec63jLmhqD8a1pUzP0antDW4tQOcEdfNTsImh+AZgIFbAVXcFlbjDjY15wNr9ZIBrWc+1/Xn6ygaJyEw5bBUu++jUrFLq59dzbUiT0FHczrzl3boYsKeeZSFqHlssi6K1+5J7w9ebP8nh2Y3cjX4KS3WVky8nP7G3abgcsF8XP5bH2+BOXlPFy0+7zw3x4q4sevZIK6NkuU7vv9wiPQuHTVGNrxriKdqcVFkvTkjEv6wyXnlN5ztVpIuyuaRUzEElg0ETAyqwEdq87HZDaUTvtxPGEzFptBGc5aP7O4AdHOb+BjR2hJ2Lzm4Y8eTq5TxPpXTh/7N5EBBYuerUK1VpvR71eKtppGI4KrIFfl5Jx16TiMf+7cylX9R2Am3sPFQ29H6cdeRDDFluS58W7SkrVSxb9s0otIuC/VFavV7w7hRnkPw41VWxOVquZhjkfWQL/GgfNkwHz8AeKuwmd7MFkz72hc7KNgKlOUnwaxwxFp6vAAAJofAIicYJ6NwOG/9QmqhaGXdTgkrMMmdP5dbgia/JVcazLYhCXFh5Og3Q7nq0p+VMBln1x3nRjP/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700021)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eW1GRWJLWHhFK2ZYclBJbWNlYll6V0YxWmR2QkxDUTg0U1F1dUN5VTJyeHVE?=
 =?utf-8?B?S0oxMmt4cHd1NnIzdzdXZVZNMkJQSUVDa1dYQXVrMXQ1Q1drVEFCNlFocXY2?=
 =?utf-8?B?VGtLTTluT3VYQzZWNEhBN1B6dDgwdStBTDFhYS9JTHo2OHlrS3IwUlJwTlZZ?=
 =?utf-8?B?Ty9vUExJbytSaFVTWGNsbks2eGxLTjhia1hhNzBKVW5qR1U3RGZaVkNEd2lm?=
 =?utf-8?B?TmEralBpV0cxMGdaVkFoclNUd0Exc3ZhZUxWVWo2aVBRNERxVzRxTW05UEpL?=
 =?utf-8?B?U2JIZWVPZ1hZMmp6OWdpR1ZuUEZGdWFISGhDVUhkV1VNL3I5UENoNnJjSmkx?=
 =?utf-8?B?U1lqSUlvYml2TzFOWEZIOWF2YThxVVZ5eVVyVFN4djFaQWw5TGRsdUtxb0pF?=
 =?utf-8?B?TWwyZ2tXWnU4SzN6YWxuNjVDWWd3Z2Q2Z0FWK3QycTFKWk9VQUhmM3hDZjZp?=
 =?utf-8?B?VUI5TXk1cmFaUE95WWsydGJzSVpqS1pNMmhSbWJOdXF1dldoS0FjZ2FOQ2p5?=
 =?utf-8?B?TFRKMmRjcGU4WUdSbnhZcFE1TG9PUDVWRWVLcFRwL2Y5ellGTmNlVVM4TzMr?=
 =?utf-8?B?eFJjM2xBY0h5YmpQRnN0ZmI1cDc3UmZuN1VhU2Y1WnhWUUxqMThuY0J6Wjlq?=
 =?utf-8?B?WmR2U2V3ZzFUS2N2eFBkNnVmQ0ZSSzNBdU16WW14ZHhGU2FOT0h1by9EZk9j?=
 =?utf-8?B?dmd6eGZXRStoMEVPQXcyeElZeTNoTkRvWWl4Vm4yTklYdzV6WitHbGJGNE5Q?=
 =?utf-8?B?ek5ESVhMQVMvM2ZwbmJhOUJtenJydkhEaVBiMjdNeTh3ajJnRDQyS0lPbEZF?=
 =?utf-8?B?T0FzUEpIWlM2Sm9NRDFQRFBTOThkaFVHMVlpR0VLdkZ1Y2UvU1l3aXJteWVH?=
 =?utf-8?B?eHgzWW0vUnA1UG5qcExtYnh4U0UzSndSZUZRdEdzYmtCYkRGejBHdXZFNUxO?=
 =?utf-8?B?L2dFWG95YlVBT0M1aXYyN0VldWFpZWt1YzNadzlpNXByb2xYMjBxdldpTWZV?=
 =?utf-8?B?Q0F2T1d3UXV6OVFvMDVZeG1JZS9NZ1NPdU9WWGFmSmpDcHd1Wm5sbjZnZlpT?=
 =?utf-8?B?eGxOZ05RUFlEdlcvMTNTYklkWTVycHkvSHdBUlJ5WEhySEw4UmlSRWNaU2dr?=
 =?utf-8?B?SndFRk13eHBZbGpuWkJET3luTlAwaHFxM0UzbjdRU2VVbDM1Nk40Y2prdVY0?=
 =?utf-8?B?ZlBuVTdUNittVk1jYkYvRlNTOEZ3NXk1RU5ONUJ0MXFrMlIzdmtLb0N2Wndu?=
 =?utf-8?B?bVVScnBUQ2Q3WXFpZ0k0bFFSam1KQ3c0ckJlS1FoeUhxb0JzV3Yvb205OVA2?=
 =?utf-8?B?RkVjR3BESTBReURJN01zWmU3L1RwQ1ZQNDhDVURuNlpOeE1VV2ZEV1hlcHNi?=
 =?utf-8?B?R1Vqb0xHRDlqT3haSE1OS01PNlZRaHd1OEVSNFJ3YU9mSnNZWmltVkhOa2tS?=
 =?utf-8?B?N2krMVRnVFp2VnZDSm1nc2VFNXhaTTZQMHJhTVBXRSsyQXozdnE0SUIxWmJR?=
 =?utf-8?B?UkJwYnBZWllBdXdzdHhPWnhzMjBIS0VaU3hVRUV4YXF3M21sbDVMNWhqWG12?=
 =?utf-8?B?SmU4YU9lRTZyQlQ5S2U1NDh6TjBzU3k5QVBDSG1TOXBtRGJjMU5YaHRJSEYv?=
 =?utf-8?B?eTVhOGdZelZaeXArcVR2R1p2dTNTanZvVnFueGUrQmhUN0l3Z0dPSHhiSDFO?=
 =?utf-8?B?YnVJV1ZFS1g1bUlHeDlteVF4QWx2K2hWaGNYNjg1RGZ1cWV2QjlUVy91WmNp?=
 =?utf-8?B?R3F3bnlILzFpT3dLbFdHakVkQVBwbnRCU1UwdWk2ZStIcUxTdVBHRXliSmE1?=
 =?utf-8?B?WStLQ245YW5ObzZmQ0crNVVSTllUZEdFSmQ3a2p4dWdZazdhOEwxR1VaaHhT?=
 =?utf-8?B?WjFPZmxaK2plMTl6QWVsMjh4dzJWKy9mQXJrdjhScjRrSURzSEd6Sy9uSDg3?=
 =?utf-8?B?dkFUYzM2T0lZYW1BZDR1cEhRRkc3QUx2dzNsVUtsc091c0cvWmgxVWRFY25q?=
 =?utf-8?B?cFJ6WU5VL01NK3RpZHlhZUVPT3B0eVdDRlZoZ2c2Tk9iYnNUY1BWRGpvTUM4?=
 =?utf-8?B?WTdkRWU2UDNVZGZBOUFGeFhzdVoyWGpUYS9ORUc4d3B4am8zWk5nWUdHZVlM?=
 =?utf-8?B?M3FIMzJlSTBuaWRRSlAvc0orNWZmZ1Awb3JYQm9NdXp3QWJwY0pTczhCOFgy?=
 =?utf-8?B?RUliS1dVZCt2SGtVYm9Xa0FkSlViZTlDanROQ0Q5eDFBcE9sOU5zZE1UL3VQ?=
 =?utf-8?B?RStIcjdIdkZYcm5rbmpNZHRybkZzczFSL01kQ1VTdVBlbThvSmJxVjYxZ3Q5?=
 =?utf-8?B?Wnd0M1FzcFh6RGJLNTY2MjFwNHdvT1haRXhYODNTUXhoZzdaSkN1Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Cu7BXwi6kQdNkX+uOrVdJOQl9fC0UMJEwIm2yHIAdPD6GmhVyiyEfgO0qPgqaPMEbQyzkAvvEWBEUeTSb5fU2dWR+2+qCWlJWaMrfAtp6MBWs/EuTzDFCQfnTM8unGo6BNeI7WrFR6yjEk80ZltVfB4hsk4OwDJfW2xfKN19nUr6icSRvnPo6iNrPbomOnjXieb9s4wx9UsIXA0hxiTg5beNrDKh5X0l12mx254uHq3aOTzIzLKaPl7y6rt19/uWnyFo+3OqoframreC6q30lZT4j+uU2dbUJPiC24TmHpnBcA0RPXtSRJDr/HMKwmKLJN48TqPO1EFioZJ42l6cDA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf24cd9f-64bd-47b3-3eab-08de93be02be
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 09:22:23.1924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ig5FJXpsigCDXTsyTtPeAC7O3fTp0dXds24P9b5icu9j5tpbURQyCpQ2YTEFQg4Fc6kFD75VKlXaKcslJm2v9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR03MB8152
X-Proofpoint-GUID: PHN8TTO5vDFgqq8CfRK7vM5Dme4K85EV
X-Proofpoint-ORIG-GUID: PHN8TTO5vDFgqq8CfRK7vM5Dme4K85EV
X-Authority-Analysis: v=2.4 cv=d6L4CBjE c=1 sm=1 tr=0 ts=69d37b52 cx=c_pps
 a=1QNZTIC90Jmhh4/qmb3rWg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=IpJZQVW2AAAA:8 a=AoFRw0SfoOhh_QyqOKUA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDA5MSBTYWx0ZWRfXy8ohouxoUrZ6
 r7LymMQ5PzmFO15XWhXYkC7GX92Hnh1/nwBXOVYPXXaSA4h4I1yUap0jpFk9u0lEMIdugS6L3RX
 2C1cRsyCK9KKlhmJ2ZdH93OfPTLXqHLL4jUVGaFC5FJaNNXzAyFJd1X1vu+XNlOAi3nEiartToE
 oq7/ekup1Ht5KFp7iYa9pqaDN2mqrLNeM73RaZ4//n4pEDRTTMVv9YgKkOp62FE68aBeLfy2hdP
 QSQGusNuRGei8MEDRuj3/hmmtrI7DUhscNNUCkGFYyD7i2e4+YRvvfDQc7pLOa1JsbRRPu8CMQc
 JgHxu8kiweytP/8oRhC8AYVDDIW2BDYvshObNtCRulVFayntq0mAKCBq51R6bsbXT/t611VjKCO
 TE1BY7qlWcnwEGqmr1euaA07/MLkaBKesDghUpRNOi2+oIpnld/TPDQ5Mf1YXxHnGaEuIs081fH
 2EjSmoFwOrBQ1rgULHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060091
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-8483-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:dkim,LV9PR03MB8414.namprd03.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-0.986];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 30ED03A29F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBMZWNobmVyIDxkbGVj
aG5lckBiYXlsaWJyZS5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBBcHJpbCA0LCAyMDI2IDY6MTIg
UE0NCg0KLi4uDQoNCj4gPiArDQo+ID4gKy8qDQo+ID4gKyAqIFZhbGlkIEFDQ19ERVBUSCB2YWx1
ZXMgd2hlcmUgdGhlIGVmZmVjdGl2ZSBkaXZpc29yIGVxdWFscyB0aGUgY291bnQuDQo+ID4gKyAq
IEZyb20gVGFibGUgMTM6IEFDQ19ERVBUSCA9IDJeTiB5aWVsZHMgcmlnaHQtc2hpZnQgPSBOLCBk
aXZpc29yID0gMl5OLg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIGNvbnN0IGludCBhZDQ2OTFfb3Zl
cnNhbXBsaW5nX3JhdGlvc1tdID0geyAxLCAyLCA0LCA4LCAxNiwgMzIgfTsNCj4gDQo+IEl0IHdv
dWxkIGJlIG5pY2UgdG8gYWRkIG92ZXJzYW1wbGluZyBpbiBhIHNlcGFyYXRlIGNvbW1pdCBhcyB0
aGF0IGlzIGENCj4gc2VwYXJhdGUgZmVhdHVyZS4NCg0KRG8geW91IHRoaW5rIHRoaXMgd291bGQg
YmUgc3VpdGFibGUgYWZ0ZXIgdGhlIG9mZmxvYWQgY29tbWl0Pw0KDQo+IA0KPiBPdmVyc2FtcGxp
bmcgYWxzbyBhZmZlY3RzIHNhbXBsaW5nIGZyZXF1ZW5jeS4gV2hlbiB0aGVyZSBpc24ndCBvdmVy
c2FtcGxpbmcsDQo+IHNhbXBsZSByYXRlID09IGNvbnZlcnNpb24gcmF0ZS4gSG93ZXZlciwgd2l0
aCBvdmVyc2FtcGxpbmcsIHNhbXBsZSByYXRlID09DQo+IGNvbnZlcnNpb24gcmF0ZSAvIG92ZXJz
YW1wbGluZyByYXRpbyAoYmVjYXVzZSBlYWNoIHNhbXBsZSBpbnZvbHZlcyAjT1NSDQo+IGNvbnZl
cnNpb25zKS4NCj4gDQo+IFNvIG1vcmUgY29kZSB3aWxsIGJlIHJlcXVpcmVkIHRvIG1ha2UgSUlP
X0NIQU5fSU5GT19TQU1QX0ZSRVENCj4gYXR0cmlidXRlcw0KPiAoYm90aCByZWFkL3dyaXRlX3Jh
dyBhbmQgcmVhZF9hdmFpbCkgYWRqdXN0IHRoZSB2YWx1ZXMgYmFzZWQgb24gdGhlIGN1cnJlbnQN
Cj4gb3ZlcnNhbXBsaW5nIHJhdGlvLg0KDQpJIGFncmVlIHdpdGggdGhpcywgdGhlIHNhbXBsaW5n
IGZyZXF1ZW5jeSBkaWZmZXJzIHdoZW4gb3ZlcnNhbXBsaW5nIGlzIHVzZWQuDQpXaWxsIGFkZCB0
aGF0IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCj4gDQo+ID4gKwkNCj4gPiAgc3RhdGljIGNvbnN0
IHN0cnVjdCBhZDQ2OTFfY2hpcF9pbmZvIGFkNDY5MV9jaGlwX2luZm8gPSB7DQo+ID4gIAkuY2hh
bm5lbHMgPSBhZDQ2OTFfY2hhbm5lbHMsDQoNCi4uLg0KDQo+ID4gKw0KPiA+ICsJc3QtPnNjYW5f
bXNnLnNwaSA9IHNwaTsNCj4gDQo+IFRoaXMgaXNuJ3QgaG93IHRoZSBTUEkgZnJhbWV3b3JrIGlz
IGludGVuZGVkIHRvIGJlIHVzZWQuIFdlIHNob3VsZA0KPiBoYXZlIHN0LT5zcGkgPSBzcGkgaW4g
cHJvYmUgaW5zdGVhZC4NCg0KWW91IGFyZSByaWdodC4gVGhlIHNwaSBwb2ludGVyIHdhcyByZW1v
dmVkIGZyb20gc3RydWN0IGluIGVhcmxpZXIgdmVyc2lvbnMNCnNpbmNlIHRoZSBtZXNzYWdlIHdh
c24ndCBwcmUtcHJlcGFyZWQgYmFjayB0aGVuLCB0aG91Z2ggbm93IGl0IGlzIG5lZWRlZC4NCg0K
PiANCj4gPiArDQo+ID4gKwlyZXQgPSBzcGlfb3B0aW1pemVfbWVzc2FnZShzcGksICZzdC0+c2Nh
bl9tc2cpOw0KPiA+ICsJaWYgKHJldCkgew0KDQouLi4NCg0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAr
c3RhdGljIGlycXJldHVybl90IGFkNDY5MV9pcnEoaW50IGlycSwgdm9pZCAqcHJpdmF0ZSkNCj4g
PiArew0KPiA+ICsJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9IHByaXZhdGU7DQo+ID4gKwlz
dHJ1Y3QgYWQ0NjkxX3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+ID4gKw0KPiA+
ICsJLyoNCj4gPiArCSAqIEdQeCBoYXMgYXNzZXJ0ZWQ6IHN0b3AgY29udmVyc2lvbnMgYmVmb3Jl
IHJlYWRpbmcgc28gdGhlDQo+IA0KPiBEb2VzIHRoaXMgaGFwcGVuIHBlci1jaGFubmVsIG9yIG9u
bHkgb25jZSBwZXIgY29tcGxldGUgc2VxdWVuY2U/DQo+IA0KDQpUaGlzIG9uZSBoYXBwZW5zIHBl
ciBjb21wbGV0ZSBzZXF1ZW5jZS4NCg0K


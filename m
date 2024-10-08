Return-Path: <linux-pwm+bounces-3537-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B0399475F
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 13:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9181C237FA
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 11:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07C11D2B3C;
	Tue,  8 Oct 2024 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WfaAAZzO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DCE1D31BD;
	Tue,  8 Oct 2024 11:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728387485; cv=fail; b=iwcqvGbZvTb1ETGhzvHa/9XDqWzvuz4+IYJqWMsL5wxprArugdZS5XkQYf3wB5lM8y9l/4G9eFT7Ce93MMpL0b1YUB1w6jeE+bh19Q/p4M+dDUZh8t8r6IBHwCaYwmZ8fdCaal4D573wghhyC9buTeU+bm5aM8xS+t3fzSB7V50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728387485; c=relaxed/simple;
	bh=nJwhnSTO1Au1YG29fBezASEhb3ikafH41Aeh0IuMe50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pq0pbSSmAuUkIURqphRS6VFLjx3yWjQILeBjQaT4uKX6jyk+WZ/9QpvquXXo74QHI2tTS0xos16Cf+RFENYg80dWyNuQ9adxHoR+6ZnbRo6jVzvz9/9f7mTIpacU+dNUpDdxT2nLfFDrWfpbAh2tosptMiFwc7bF4OwEsdd/sM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WfaAAZzO; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498AX9YD021878;
	Tue, 8 Oct 2024 07:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=nJwhn
	STO1Au1YG29fBezASEhb3ikafH41Aeh0IuMe50=; b=WfaAAZzO+9fRqkeRcwP93
	HWjjcukUvVGBpCyT9BYHQx1mbSTcsmF3YbeqQb/1jMdD3KhAAwLTk0MIIhTCSDLt
	qyrspehe1mGMhcD9P8YAEauNpR/YRlBJwm91Wa9hRtveJEqskzQ0Oaya5CieS+Xk
	44wZ5pHhUF5kPCq7gCwmTB9FFvr9Q7lZBVXw1PW2DSS1Xjc1xRSNgFsTJE0olENp
	VtTsgaQQ1gAGJJj8Mqp5oIWLTJYQgxcLerhOGx9UOWfU5lEQ09iT6JWoPpwbRFjZ
	rD+HJY03c/KEBV7XTdx1czu6MNOkoZy9goNcy2+pcuAPMNB1YAK5g+L0YTDs6dTx
	g==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazlp17010007.outbound.protection.outlook.com [40.93.1.7])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4253308629-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 07:37:24 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJ/e9shS9TQ7c0zQlTiBQqpFB4PbigP2lfHeheiusGxx2kO0DN+QvLtAkqdeuiiEPk+2i0aHBC1E5TEHG1aiEdATVrSZSedn7N5jMGaCp3FPTW5Rl23BGscDhpBoXpVIqjF1THJ1gHfJOSDfBXVara+wWyzV0USWfwnBt4nln/+AgpzeL2yyRRY98xUgM9iMZECe4y1vQgeBSfUAqyBe0BMeQbWpTSXWUzyQMNoFL8EHISSaSM/LGxgBHo/jdZZyo2o0Zfg4HEqzf/itDA+efls9tMfqmE9cECWFQTo4syTRmWPHfzgw7W3cZMaHLIt6OTboJxyxmPZiaSGtBcNR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJwhnSTO1Au1YG29fBezASEhb3ikafH41Aeh0IuMe50=;
 b=t4tbI/gLwncsHC5MzkdPALHWVJCSJCmFNAWL3QbbWs4+Jr51Yb8FGcPFNNk8VZ6muUtjpCfe968VDsNC0RHtCFIuIB8R0v8KUzNWELkblRrmDceDKMsQ7g+GUZh681lPrLR2DCqm5aseUMTFMKZxgU4p5KU6F7JjAnKL7i9AKxW6XtzLYXN3oSv/CyMugXv4JWwzTTRs17EqV7mCQULsFLVSwy0rlakZ0qNWH1ak0kes3JCRemWT8+1hH3uEfgrOcA+X/FtQmFDiwXBU0QL3TdZpIFrdso1jpXUk/iRpVH7VaIV3DVK1L3BnIjNLCjJprx0HX803DKdPdUkASCiS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by SA6PR03MB7830.namprd03.prod.outlook.com (2603:10b6:806:42a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 11:37:17 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%4]) with mapi id 15.20.8026.017; Tue, 8 Oct 2024
 11:37:17 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<ukleinek@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        "Schmitt, Marcelo" <Marcelo.Schmitt@analog.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Marius Cristea
	<marius.cristea@microchip.com>,
        Dumitru Ceclan <mitrutzceclan@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Ivan Mikhaylov
	<fr0st61te@gmail.com>,
        "Cuciurean, Sergiu" <Sergiu.Cuciurean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
Subject: RE: [PATCH v2 6/7] iio: adc: ad485x: add ad485x driver
Thread-Topic: [PATCH v2 6/7] iio: adc: ad485x: add ad485x driver
Thread-Index: AQHbFmd2i/Hp4PBeYUypvnokWgp3WbJ4gweAgAQ66JA=
Date: Tue, 8 Oct 2024 11:37:16 +0000
Message-ID:
 <CY4PR03MB3399684E3021A1261DC5195B9B7E2@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20241004140922.233939-1-antoniu.miclaus@analog.com>
 <20241004140922.233939-6-antoniu.miclaus@analog.com>
 <CAHp75VeaYBGTA7sN7SefsyMj09kaJLBoMz4=hf0GpxiXtF65+Q@mail.gmail.com>
In-Reply-To:
 <CAHp75VeaYBGTA7sN7SefsyMj09kaJLBoMz4=hf0GpxiXtF65+Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jWVcxcFkyeGhkWE5jWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTFoTjJWbE1URTFZeTA0TlRZNUxURXhaV1l0WVdaaVppMWtORGd4?=
 =?utf-8?B?WkRjMU1EWmtaR1ZjWVcxbExYUmxjM1JjWVRkbFpURXhOV1F0T0RVMk9TMHhN?=
 =?utf-8?B?V1ZtTFdGbVltWXRaRFE0TVdRM05UQTJaR1JsWW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STFPVFFpSUhROUlqRXpNemN5T0RZeE1ETXpNRFF4TkRFeE1TSWdhRDBpUkZC?=
 =?utf-8?B?WEx6Wk1hVlJUYm0xcWNGSm5MeTlOTDFaNVYwZzRZVm8wUFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlJXOURRVUZCWmtSQk1YSmthRzVpUVdKM1FtUmxkRmxGS3k5Q2Rr?=
 =?utf-8?B?RkdNVFl4WjFRM09FVkVRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVaEJRVUZCUkdGQlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVWQlFWRkJRa0ZCUVVGdGFUZEtiVkZCUVVGQlFVRkJRVUZCUVVGQlFVRktO?=
 =?utf-8?B?RUZCUVVKb1FVZFJRV0ZSUW1aQlNFMUJXbEZDYWtGSVZVRmpaMEpzUVVZNFFX?=
 =?utf-8?B?TkJRbmxCUnpoQllXZENiRUZIVFVGa1FVSjZRVVk0UVZwblFtaEJSM2RCWTNk?=
 =?utf-8?B?Q2JFRkdPRUZhWjBKMlFVaE5RV0ZSUWpCQlIydEJaR2RDYkVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?blFVRkJRVUZCYm1kQlFVRkhSVUZhUVVKd1FVWTRRV04zUW14QlIwMUJaRkZD?=
 =?utf-8?B?ZVVGSFZVRllkMEozUVVoSlFXSjNRbkZCUjFWQldYZENNRUZJVFVGWWQwSXdR?=
 =?utf-8?B?VWRyUVZwUlFubEJSRVZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkRRVUZCUVVGQlEyVkJRVUZCV1ZGQ2EwRkhhMEZZZDBKNlFV?=
 =?utf-8?B?ZFZRVmwzUWpGQlNFbEJXbEZDWmtGSVFVRmpaMEoyUVVkdlFWcFJRbXBCU0ZG?=
 =?utf-8?B?QlkzZENaa0ZJVVVGaFVVSnNRVWhKUVUxblFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUpCUVVGQlFVRkJRVUZCU1VGQlFVRkJRVUU5UFNJdlBqd3ZiV1Yw?=
 =?utf-8?Q?YT4=3D?=
x-dg-rorf:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|SA6PR03MB7830:EE_
x-ms-office365-filtering-correlation-id: c335a924-6317-4d20-c4a2-08dce78d8fde
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q1dKc0doUkdUTk55Mk40SzkzdGszVlRBWTBEeksyZitNajE0bHdHcWdCZjVY?=
 =?utf-8?B?WHJzcEY5Y2M5VjlINkFDdTNwZGpVcTVCUThsMGdRZ29qY2Y5V3N6ekhNY2o0?=
 =?utf-8?B?L2xFWnRQLzlncENqYVV1bkJ6dzZJR1R1U09tVHEvQnVheUpCLyt5engwWEdL?=
 =?utf-8?B?MlpSa0dPdnl2dGJYdnFzODllWWF2UG04M0dXelFpMmQrQ0s2YmJyeEgwUmly?=
 =?utf-8?B?cU96MTdTVGU2L3JNN1dBQ2hyaEhER2l2NDJFbGtTUzFiVlNISG5wSTFFMnpT?=
 =?utf-8?B?WTRmTlZTeGtxMVBEaEQ5NTd2aDNtR1padkljZnl1K1EvM2dmbkhiNWVUU2Nj?=
 =?utf-8?B?dy9Bb1NuQ21YOVZBRUhmTHlOMDIxZ1VmbUN1TnY3aGdSYVdieHFma2laY3hV?=
 =?utf-8?B?NjhFeEhzMDJZZ1YxNldJRUx0RXNMZ2NXMTViZ1Evbm43WHQ5NXdvcm1pUWtT?=
 =?utf-8?B?bDM0cVFtK0Nzb2F6TVgwSEJQMG1XWjMyNXE5UXh4bU1TV2VkTlJQQ2xtYnB6?=
 =?utf-8?B?T1RiVlUxd0x6UjQrd25XVW00S1ZhSS9LcWhHRmxVeUFUcldzMVVNZUpPTDRX?=
 =?utf-8?B?cW9LQVZCOHNmVmI3TnNMZ0VlS2dUTndFaGVEeEZ5UDBscmpINWtKMU5ldk13?=
 =?utf-8?B?RGdXZmxBZkZYNTNWNnNodXVETC9ERU4wcDVpUWdlR05CZkZyWVo4aU5OMVFY?=
 =?utf-8?B?cTNkdU5sYnlRVnpScDVZRERjTnFIOWc5S1d6SDJ4eG1zb2FYbTArOFFScHZx?=
 =?utf-8?B?SzNrTm03dThJdGV5U0FESTVqZWgyTFBqUU1MSkZvRHM0NkNiSFRMUHpzTVZH?=
 =?utf-8?B?YUJYUERsaWVLN0dVR2kvaU9kV28yY012b3JaTlhLd3F0eU4xVFU0ZjZqN2FC?=
 =?utf-8?B?RktoNENyRzJSMXF2MnVFUHRSMWRja3MxQ2NiRmx5Wk16MHhEOXV2QytUbTNO?=
 =?utf-8?B?ME1WYTdxblgyRXR6SkpHSUVXcVdYYjJjZDdRZlNPVHlPcXA2TnNOL21aY2RS?=
 =?utf-8?B?SW1iaGRSdXAvNEovNWh4MEZIdktIUFNqL0RSbi9odjdNUG9aVkxkbTRrWGxT?=
 =?utf-8?B?MHpMaHRHRjVDNlF1UWRSdjdIYnZERHJzUzJDTWFIM3pvclFrR2hrSmQ0b253?=
 =?utf-8?B?YURQWFBpU2ZHa1RuWFVNQm9Db0dJekFlZTZFTnhrdE1iYkxLZENkc1FhdHNv?=
 =?utf-8?B?LzZnT3ZQSmNOdzJKRUVsN2xTbE9pY1V3RmFVdjd2ZlI3L21YVXNtWnQ1Zks5?=
 =?utf-8?B?Zy9kOHNCS1IvaEdoVnBBK3pSekF4K2hjd0grNTU1bjBjSktCTXBUV0pKTFdm?=
 =?utf-8?B?bGZZQi9zZHhJaUVuV3hDK3J2MEhWUTEweXQ4K3R4Zi9LTytmU3RDcTlBTUdo?=
 =?utf-8?B?cVZoTXROcHczdDNsdVJVSFp3bUFhVXVPdDJaZDFLK1NhVElzbXhtZytIWmRv?=
 =?utf-8?B?NUlRcitod1BLQWlTSmtzajVTazN6cWhDU2t3WUxZSmo0T3crK0NIRnlGbFgz?=
 =?utf-8?B?TFU5SDhIa1FFdE1rZWlrRUlUREZmMGhYZkN2VjhmZWZmWHVJTk9KZ0Z1bEVO?=
 =?utf-8?B?RHR3QWt1eFY1Z3ErUzBRY3VLKzBNT09IUjQwL0RrSUhlWGpRUmpUUnlVZG9r?=
 =?utf-8?B?a0ppQzV6Yk5OVW55ejNiUnZvVW1IUHdyemJBSVFPTjJIN2dQNW1JTzZUbEdO?=
 =?utf-8?B?TkYxM245ZkVUTmtndExvQ0VRUXYvZWUyKzlSeEJLUThMNnVmM05IdGlaYnBu?=
 =?utf-8?B?bEptdk5YeThUaEJNWFJLYlh4Q2lKZ3o2dVdYMnRBZk5mUkIzZ0lSc05YMXBy?=
 =?utf-8?B?S0g0K01EMENxQytNM0FvZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1UyWXdJUlFzYTNPM3MzSVF6Rm1CQk5GRk1YRE1WQ0VQMmYxa2t2enFmS1RC?=
 =?utf-8?B?QUQyd2NiQ29CTzFWaVFXUitxRHArWHJMM0RPNzNCUnRzS0gvZDNOeGM5cmFx?=
 =?utf-8?B?VVU4b0UvZ0QwU0tqYmQwMkgrc3IzdU42TjE2bVhTZm1Pd2E5V2pLTmEwcS9i?=
 =?utf-8?B?ZDBxSDB5dUhWcTJYb0NueHVlQkNheWRGN1ZMN3BiTkhhMVFsUTFmQ2VtR1h4?=
 =?utf-8?B?VFRFdDdUNnFSSHp3OWRZRzEwM0ZLUWoxS2crUTBMZkNCYTRJcDZBeDhrRDZC?=
 =?utf-8?B?TDd5eWNtSzFKdnB1TXZiTDdUdWJqODRRZmZXR0h3VFdJN2JQamg5OVdXYmVw?=
 =?utf-8?B?bUxaVzU4emhwdUV5NTd4M0szNXB6RThOUDBtc216MjdRa0QwaDluM05iVHdZ?=
 =?utf-8?B?Yjd2ZEQ1SVFQenpLNTB5SlVQL0pHVnZKMFVLdG55WGtnVmtDWGdGcGkycHFk?=
 =?utf-8?B?djBIdzhtVWxLK25RRlUzT0d1cm1Od3crMStBTktQaS9MQXRYZEgzb0VUdE1u?=
 =?utf-8?B?RDlZM2FMZnJXV25qWG9PVlpNTVRLNGliNFBxY2k0VUp6WmsrN0wvZzhjcEU0?=
 =?utf-8?B?a3BiWDZBOFlQdFh3REpkaW82eWtONFc5ck83cFdZZjV1ZDFHc1d0S1hUWWFW?=
 =?utf-8?B?bGc0UktiL1A3eFphWk5aVVVMRHYxa2xUMmdMTmZVME9adWYrVmJaa2FxMXZ4?=
 =?utf-8?B?TjlVMDFsWm1uZUJudGs3RmxsNzIvL2RXNGRBT1I5VWZIQ1huVmJ2VFdsR2Zl?=
 =?utf-8?B?UHBSVTNmL0gxQlNhT2VXWndNSjVNMHFiemtRTkRiUDhGYmpQc1prTm1BQTZU?=
 =?utf-8?B?OHhuT2dlRVAzRGRYM29XQUpMWnQwZFVST3FsZDYzRVo0VWFKeFRndVB0VnpX?=
 =?utf-8?B?WTdDZEJ4b1YwdE1FS2Z5YjBWQ3lXU1FneUlDb1E4TGo2RDU3OGtUL0NvbUVR?=
 =?utf-8?B?WmVSMU82d3Q0c21DZ3FSWm50aFRGMjZ0clZML00xWFEvclovcFRTWDdneERq?=
 =?utf-8?B?c1pxYlBmaVhmY2xZczVSbzRsN0dSRzZlVXZUMWwxaUNBVlZpcWN0R0UxMkJX?=
 =?utf-8?B?aS9DTk5kT05ZQWVROUpWVTBLZW1UZ28zeFE3ajIxVS9YcE02SHA3UEFEcW8r?=
 =?utf-8?B?enVLWE96Qm5EZElZVnhIYlRSaFFGWGlDYVA0RGNGUVRBN0VIOFg0dE8vaVhZ?=
 =?utf-8?B?dDhxUnN3SkR2aWZGalE5TEZrbTE0dkJMNHJkMU5ZOHBhZWM3RUdlVkdkS0ZG?=
 =?utf-8?B?MXppMTRVUnZ4YXgzb0dHRTgwZnJ1WWVYR3o5emJyY21VZ0FyOVByWm11TFM4?=
 =?utf-8?B?Ti9JSmpNRE5lbEtmckM1NXMrRGFoeTRzcm12TWdJWTUxcTVlWEozbHFtQ1R4?=
 =?utf-8?B?MnZ3a2FFSUMvd29UbzJVSG9MMlpPc2M5d09GbVQ4eDVnOS9kdFd0RjZ0b1g4?=
 =?utf-8?B?K1ZWMG13TlJEVGZPY2pXZCtVV3dtcHpBMU9QWUd1dEwrV1AvMGcySWZuMVh1?=
 =?utf-8?B?dEhpc0Y3bUlOQytsaVBVT2NuZ09xVUtoZ0laQUlsbzFDRXJ1UExRSHgwajRG?=
 =?utf-8?B?QkZmMkw2VElmVkFTSys3WWNGaWlQQnM3OGp3b2FOSFBTRXFnb1RJRDdLeTVz?=
 =?utf-8?B?d0dyT1BFRTFPbjNUajdvT1M0allaOEdBMjd5dkdKdWM2NHFXdmtjbTNQRkkw?=
 =?utf-8?B?OS9lSXhwRm1tZ3BpUVUrNGM3NnF4RXdpbVc0NVZidUZzTnpTNnE2aVNqVnJr?=
 =?utf-8?B?OHliVkhJNms4MUtDemlxQSs3K2hEbzYzbEJ3TTRuejNhZTFOV1cwOVJBZzRF?=
 =?utf-8?B?Sm13KzJ2eEFLaXo1SjdLeERNb3JxdnFwMTdySEFRaU1BTjc1dWpoU3Fqd1FV?=
 =?utf-8?B?TUxZMVFLNlZqdzE1ZDVtV0NRd1QrNXJRN2luUHJ5SVZqTEdsMmpCdGxwRnI0?=
 =?utf-8?B?ZEtDUzJiV0hXWUVKSHJmV1VtZGFFUWdNUGZzcHh1cTczVXJvbEl1c2VNcXlH?=
 =?utf-8?B?Ti9KbGZDNnVVZW1kc2VQWTlhaWo1V25KREgxWDhRSU04cExXQkRHYTJOOXlp?=
 =?utf-8?B?NzA3UVJYZmM0QlkvRmlXMThzNkgxOXVLS3R6OHB0SXNITExSREM3R2VDNDZ6?=
 =?utf-8?B?ZStvbmsyQ0oydjJ6NXVpeWdpeEdWYldXdVA4dDU5WkJMaGpwU2JBVmQ2bk1P?=
 =?utf-8?B?N0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c335a924-6317-4d20-c4a2-08dce78d8fde
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 11:37:16.9470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SGGDCISjuOhPNFO021tPsMtpafBLgxHGuO85Ui6ZNPEJu1QBDeRIpdoSjr9SvGhBLDVtTNJbKa3m+VkhuZAaWCybXpKSB46RRbat+aAZFKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7830
X-Proofpoint-ORIG-GUID: HMfeSymzfNe6jQRR50gRDqg-bOrEjDFv
X-Proofpoint-GUID: HMfeSymzfNe6jQRR50gRDqg-bOrEjDFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=670
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410080073

PiAuLi4NCj4gDQo+ID4gK3N0YXRpYyBpbnQgYWQ0ODV4X2NhbGlicmF0ZShzdHJ1Y3QgYWQ0ODV4
X3N0YXRlICpzdCkNCj4gPiArew0KPiA+ICsgICAgICAgdW5zaWduZWQgaW50IG9wdF9kZWxheSwg
bGFuZV9udW0sIGRlbGF5LCBpLCBzLCBjOw0KPiA+ICsgICAgICAgZW51bSBpaW9fYmFja2VuZF9p
bnRlcmZhY2VfdHlwZSBpbnRlcmZhY2VfdHlwZTsNCj4gDQo+ID4gKyAgICAgICBib29sIHBuX3N0
YXR1c1tBRDQ4NVhfTUFYX0xBTkVTXVtBRDQ4NVhfTUFYX0lPREVMQVldOw0KPiANCj4gV2h5IGJv
b2wgYW5kIG5vdCBiaXRtYXA/IEkgdGhpbmsgSSBhbHJlYWR5IGFza2VkIHRoaXMsIGJ1dCBJIGRv
bid0DQo+IHJlbWVtYmVyIHdoYXQgeW91IGFuc3dlcmVkLg0KDQpCb3RoIGAgaWlvX2JhY2tlbmRf
Y2hhbl9zdGF0dXNgIGFuZCBgYWQ0ODUxX2ZpbmRfb3B0YCByZXF1aXJlIGJvb2wgYXMNCmlucHV0
IHBhcmFtZXRlci4NCg0KPiANCj4gPiArICAgICAgIGludCByZXQ7DQo+IA0KPiAuLi4NCg0K


Return-Path: <linux-pwm+bounces-9207-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHhcKSB2GWqQwwgAu9opvQ
	(envelope-from <linux-pwm+bounces-9207-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 13:18:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEEF6017A8
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 13:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0499F3014128
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 11:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855F43C5540;
	Fri, 29 May 2026 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="S/NuuInR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166EF3CFF72;
	Fri, 29 May 2026 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053454; cv=fail; b=YGWhI1ujICSY0yWCz3gxPYpvTE1rTvlPAH5doMc9lT9FRJuFU0EVFBSdOkq6jQRr2801SEIMKUAhcWsA/3qTyfwgs7r9tBFmYDtXJEP4hkrFTZzSDUFaxWKkvT2oIAGZ8bRkro6wHA+OluPwRJ5IgA3tYyRek6Lo+i0/5smxVnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053454; c=relaxed/simple;
	bh=VDV3DR8RkqtO8qseOoAg0IqWKyI6GUEME0EFA9niYzw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l8pRLWtE987kukU8DIUL05BDKRcW0NT4RTjeCndYNEYP0D60GmfOcqBjEJm13TGk8UXjE6hbnX8gyLRQw4yfGMECoD/YKtVKsWiLj/5SxjbzVxarIL7HeTdqaCZCLJSLNvEassvW0svMTRACc9Sposl1XqMPJ7zl6qJZuv9LjXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=S/NuuInR; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T8tlsD651287;
	Fri, 29 May 2026 06:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VDV3D
	R8RkqtO8qseOoAg0IqWKyI6GUEME0EFA9niYzw=; b=S/NuuInRcDlfY4g9o4BVo
	AGWxNbh0fF0zYB1YxN19119ZeWHOLtoe+MtpmRzxDoqbx8o48CpPrIJYOT5X3nwj
	vtz0IeOQqcMCrBYPgeeFihpNQXuRdGn+Ly04VjfaxzI1VkbCZLuqVx//L/cGq62I
	WjT3Ox4AIpxJaJI9ThSgdqEZlvDnVqE8ieDvVcaYR1ScZY+mWl4cTBDbA+BvtUcJ
	QVRiflj5vpYsJ8NaAool1VVSKxU5ROo4UcZw0/kjBcbcWn2v1V75mCziFmVfFVtS
	ywFM7Mnvt0XoKJ55Hz/+p9S20uj2iH0+d4hQL+zB1zgamzjmauzhjW4RkyYBIYCZ
	g==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011022.outbound.protection.outlook.com [52.101.52.22])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ee7x46u5j-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 06:06:47 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8CC8D64BeTkDuD1dZ9yQ6VIBTz4dpCTS453jiGBnB7oKTpnRgmVbj/dOEo7jCsDwcgHXoGV8YXSVtdcsHSlfLWJ+8pk7jvk4B+Jy6zeWZk/jEIChaHeF1fB6ym7JMziqFz2bEROIV/PHhGx1/Jdwkz6uo2A08SiOEMqBGyrqiKrACOISgsASsliMcUhLw/Gi/h5GVSPJrDInniGVLbJY295yu3oINu0Qiu4PQDxPrChLIda9kpRijuJJKh1WDbExJUlmz8ySLrnzQjl/wKh92HPgbDBZHu7JuL1z8mr2mw5J2Qa/3aUZYZ+tvMDBYTCnnDqgFBeR0r8KYgl6MqrXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDV3DR8RkqtO8qseOoAg0IqWKyI6GUEME0EFA9niYzw=;
 b=pwRkXVk3Xb5BNgA3TvTddE2g5c/n8W9EeBqC+9B2Oi3SjiPhObjo9RDMsBIGPbgtea75zf14H/VsG+gnOkiLTHUDGmQaIxlOxjrtfBP4gc8y5PKbAwk4aOCeM88s2H8j6rLjFQLw+lgzxUcavFn3i9a3f1+7xY6VGISJRrwabcL+cqqwZ1ScmkxK3A2w+OtjpsF2nHU7Z++sZ+7uwKXi1bAlHQEMpPWUBsAkzTobFQ1t+YBv0CXW+Wf50VvXA5slXINrFXztpSKSUtje62Nh6XLhhsIeKCxBxHspMX9Zy5bdFcTt4ZqQeH2dafxxE8ydsKWLQErTdAuwvLUlLV9e3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by IA1PR03MB8358.namprd03.prod.outlook.com (2603:10b6:208:59f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 10:06:44 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.21.0071.010; Fri, 29 May 2026
 10:06:43 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Radu Sabau via B4 Relay
	<devnull+radu.sabau.analog.com@kernel.org>
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
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
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
Subject: RE: [PATCH v13 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Topic: [PATCH v13 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Index: AQHc7C6ynrrMRrFpuUKd6Qi0SnLr+LYiLuyAgAKd49A=
Date: Fri, 29 May 2026 10:06:43 +0000
Message-ID:
 <LV9PR03MB8414155D0BA8AAAD6A66EB71F7162@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260525-ad4692-multichannel-sar-adc-driver-v13-0-1b7626d3b35c@analog.com>
	<20260525-ad4692-multichannel-sar-adc-driver-v13-2-1b7626d3b35c@analog.com>
 <20260527190713.1cba1e89@jic23-huawei>
In-Reply-To: <20260527190713.1cba1e89@jic23-huawei>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|IA1PR03MB8358:EE_
x-ms-office365-filtering-correlation-id: 812d74f4-1706-4d63-8b76-08debd69fc86
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|4143699003|11063799006|6133799003|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 4z0ZqgBDhg949eCRkCh3ZaGSnAPC/pit1epETLiEKq0cMckUFii3a8fzbLhoHQ/1BC5CAQzVR4T22A7+onZwnh6A/tXSNYgMK6a+2jaMw2ebb0XLLR1tKmjqrbuOE+B3z0I3qFKUxquMAAIN1Z9Gd1Anwuv+9E/+fvqfJxxZeMsTivAOFQO9O5bHkEv1FfgKBr/6XfZjlEinMyf8rB7AzXBLU8NmhKXUhfhlcxjuyWi45OqJDpJUnUTs6e/JWQELnv+vWJhf2sIs7akc5YTY92M0+l/37mQr5sh0YmEsvLJcok7VrZHuijr8JTDAGaI4Cw4YxaycHgPMKXjoQ2wvTuLb9t0xZk/TTK3hibt9Va2/NXBUeXOX8UHFS3y0wrXm1ecoI1FORT5lXwXxS8mJgRnIatjXNTSMaWl6n+lJFJNm2rR369WPejKv3Nrbfd6TEHz9erPhaEcfUqEd2FueeTctnvUJBcPlSXf+RHqrOjfw8QSoymWqOUR5ho7W2S7HMXSjuibkwOfjn4Jjr63OeKxY/truIY/ziE6No3/vrVobdvm91GWkA3YbK0DVELRZMfpnZWVHzBUdzLKCd0hfC9kisKGkIcN4L4p8wXjGcLmjbMgDk8nCCIbZ942AIfWLE9aGP+QKrZI5J5tmU9fyX49kM8NeJB177GaS+bNhWC78Rh7L9VSyIX39t8pC5yO3TG5oElqnkETdHffPG0hQxx0JWYHJHp34bU8cteXIACxr/eOeImVmdZMQrveJke5p
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(4143699003)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QkQ4YzFYOUNRZVBiOHk5eG0zT1JLRUtpNEduUC93VkYxTGFmQ0JrRUtYTUhn?=
 =?utf-8?B?UFFGZnhIVUtWSEkwMmhCaE9mdDJ0UnNkUHFodTJ4d0dacWJzRFliRjB5c2dF?=
 =?utf-8?B?V1lEV3VpTlk4bEQ0K1hWajROVkw2dmlwbE82UzJ2d3I5VU1rdHVDc1FpbXhn?=
 =?utf-8?B?M3Z5OW01amFVRjlKdlFtWnNjK1dOR200U0U3UjBxK09WaVhnRTFJWVY1MlhZ?=
 =?utf-8?B?d0dRRDcrMlZ1dUxzaXNpNm5jRE9Jamx6Ymt5bGgzaDErZk5kNlViYVVRdTkw?=
 =?utf-8?B?b09Sak8xdmpXc1ZBL0pjRm5ILzN4UFd5K01ycnppN0FVV200OXhMQUw3UzF6?=
 =?utf-8?B?T29rYUFrQ0pMSWRWL2tqaGJEU01EQ0RYcjh6bWJIRHJ3aW1hNmJkSzE0UWhl?=
 =?utf-8?B?cHN6YzdtR3FKR09ud0tmT0ZSUS8wMGUzZUV6bWFOL05kUTU0MEozSHhUMTZF?=
 =?utf-8?B?SytZMXo2NTFKVGFTL1NxSGRXSnpSODBKUGtGUy9EV2MwYXBNVlF1d05BeHVN?=
 =?utf-8?B?TEliS2NLU0x5STlTWWhGR01iVlpSSmJzaDNZdFp4VElXMllEZEkrSDVmU3Fi?=
 =?utf-8?B?V2QxTW5YTkE5S3k5MWl5c2FVNU1KTTNmK2JoUDgzNGM4TVlGQy8vc2NGQ2VC?=
 =?utf-8?B?NTZTYWEwNFNJRHNjV2hDVmVVVEpQTVIvTUZPM1dKcmFzQVIyVEVUcTFiTGNh?=
 =?utf-8?B?QW0wNVJsSTZFOFBPMkRZbkZYSFliT3E1bFk3WW9jbmJhMHNaVFR4VkhyQTI5?=
 =?utf-8?B?eWxDRFhxNGd5V0RnVDFuaTZjVGoyMFYvTHdQS0Z1NWhhOVZMWkNuYW5TTFV3?=
 =?utf-8?B?KzF4VGZwZzRZb01pcERWNkVzLzNibS9yUTVTcFFrOTlaaGptUVR4SklFTUdB?=
 =?utf-8?B?aDkrUzBWa1BieXduWlJHVVI0NWJsMEl3cXdNRHp0MndQckpqZmdyM2EvTloz?=
 =?utf-8?B?MWpYZUViVVBzZ2ZNdXFGV3JjUnhYSUc3K054WkV1Z0VRRHZiWDBzNmlzalVO?=
 =?utf-8?B?V2ZqdEV2VTBXazR0SGFNeUxsNFk1Z3dKK0hpekIzeHVEQ1RxUmxXV3hOUFpO?=
 =?utf-8?B?dkZIV2E4U2x0RnpvREVXcThyMGhaQTNoWHd3NENpUFNlV3UrSC9nU3pYMk8y?=
 =?utf-8?B?RVpScnhMNDBVeDliNm51R0lSK3p2bDFnblZuM0JES3ZRL2Y3elN2VHJmc29P?=
 =?utf-8?B?MUZYWWg2NFBPYTJRWVdjbFJSQ3RLbkRQVzExdTFKZURTTjZoNVNEaXErS0dC?=
 =?utf-8?B?NTA0ZWRnZ2xjdEpnb1hUVkFqeUZYOUVPNEZUQWtoQnpwOHpXTnZKbmVCb01K?=
 =?utf-8?B?ZkhIaXN6cWpoeDlBUmVHY2wxUHNYU09QR0NaRmkxOUFGYWxoT2pDWmdnWXFX?=
 =?utf-8?B?d3ZrWkcxY1ZlUlIwSEtXenJ1MTIzYVphblRtQTNBV2RQNGRWNHFBYlo1UEFB?=
 =?utf-8?B?c0M1bnFraGJHR2p5Q21iTG5pSnpFeDVqZUJqUjdLbDd5VGF0UEZrWmNaQ1pw?=
 =?utf-8?B?TmxGWVBaWk14Mmw0SzZqRGZyTFc5U292aFI4RUFKTlJOV3dCUG8rSW1CMFk1?=
 =?utf-8?B?VVUwNzNERjd2Y01qQi9uY2FsTmY5ZHFNU1FzTU96dzNWeER6RUFwMldodjZS?=
 =?utf-8?B?QzVQd2MyUEhzWC95WStueUQ4Yi90N0lNcGRJblNzN3VMSlhobVdOZCtyUzha?=
 =?utf-8?B?dEpETlVvS2dzUGhxRnNreWlQSkh6TUIwSVVGcjN5czZkWmFueW4xUnNzSThs?=
 =?utf-8?B?K1hhemxYOFdrYmhUdjA1VGtIUTV2aUxjUW85eEM2eU1FRHQzRGNVVzY5WUF1?=
 =?utf-8?B?TEozV0dDMm9ScG1RQWVqSFNoanNnS0xsMG9RL1R5dEZVZFVMaFQvMXhoSHpI?=
 =?utf-8?B?STB3SVRNUzNUbWxHRGhSUnhUYnplYUpaMCtlTUF0aC9MeTdkOWQ5SllEY0Zl?=
 =?utf-8?B?cGNVVnJCc0NCa2ozc2pqRElHM1Q5WlRva0NQMVByZGtINVQzZk9RbnpoSWI2?=
 =?utf-8?B?YnpuL0JqN1VpcUFSL1I0K0dGZkJPcHZSL0daT0I1NVpyT0JHWml1V0VVMUEr?=
 =?utf-8?B?MjhnSnRzMUJpSEY0VHllaVU3ME5FNzlWS0FWWURPQlptelNkem16Wm12amc2?=
 =?utf-8?B?VFFOeGdGVmtGamMwN3B6ZmUvQ3JUZmhjSXhLdXZzTXEvZnFxdVNWYlF3OS82?=
 =?utf-8?B?MUxBWDh3YVRlUStzM05BeWpzMkh0bEgycmNDOE80Z3BFTXlja0FqdFRkajVJ?=
 =?utf-8?B?TnZ4Qytrb3dCdWNzcU5adGYyRlRucWx6QWtGSmJSL0JNbjJ6QXZTMUp5emVs?=
 =?utf-8?B?QmF6VnVmREdudWQ1QkVOUldNL21nQzlhclM0Ni93RWRvSENMaEQ1UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	CE/q9x6mTxB0+ftf3tEnE0Z2D2fkiv0UNagWdC40uub0FeiUNWhBbMcy+B/ilSRJlbLkJM2uu0vRM5TP+qR9laRPNIM1W9vhJAKe4fwJsKc3zHWS1tolwKxCZic59lvx/IKC+YANKoCwyh0TeMI2sgkUEfw7YE6SVklmHzMTOzi53oy7FuupYkmtJDWAvMN4nWwPGuHkotJ6vz4FNLz4YdkJU5gC9n5HlJmxv834JjdFf3Uh5tL5SafQm5YE3EGiYGB9xWpZegPFauEeYwTmoVO7lKFJxosgqYZcz9l7HIrlTgYCdUMR2TjueTWuFqF2kCeGiXKA2arnbQWLNPGSuQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812d74f4-1706-4d63-8b76-08debd69fc86
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 10:06:43.9038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NLgADJwh7PCyFi+E7qEHdkkaTmnJyzmT8cXj5pxG9Av4UkgVkCIqg4H+MqeZF4MDRCceobqRsH5ED+eNYqUxNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8358
X-Authority-Analysis: v=2.4 cv=X8pi7mTe c=1 sm=1 tr=0 ts=6a196537 cx=c_pps
 a=3RjCkzAZQHL7PUncwJf+GQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=p-bT5JZeb4596wWgEYYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEwMCBTYWx0ZWRfXwplyORUebPvi
 k5abFE05FU8+HJYQB4Q3CZ9W8BpaX1XFgWFZxrJPsk4jb6nSJmt4iSXn/5Kz6D9RZ+t5SUpRBt3
 DsGytfeCwEO6pGYIdtul44J5JeZOPliM8vap7NuxOORokG/jGvuRtfDVR2DfFMcvo9PR4ti1A2+
 myKThZ8VR/XIIXCj65qwcNKdwuNu5TKQ/ej2lJqMl0xuN3FP5GePPJ6EDv0ZhT/VIk0bRd6WAEK
 8D3j16nRnHcekK0a5Ghy2y7fXPPAncD3gvMxwbZ9rfMoe6IJL2h62dAIuGKlWYFIXFeh9D64pFn
 ZcMDVArGD2cHj/l7cXQX5JpRasY0H+6Vv4mHWKsO/mMXOJoLOQ7DHCt+KwG7Po/6/C5pU/FKcZX
 l/nFTvofnxxeG6fxEDpchnQdomy39b4y6/BdVEgv0CcKqnXV8XzDJv57EABPsdhRPZmPW8rwlJI
 yHMnPI4iynzFFkUPBjg==
X-Proofpoint-ORIG-GUID: AA0XYdQQcD8I9AemKPm9P_2v3K6BHwaS
X-Proofpoint-GUID: AA0XYdQQcD8I9AemKPm9P_2v3K6BHwaS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290100
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-9207-lists,linux-pwm=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[analog.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5EEEF6017A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE1heSAyNywgMjAyNiA5OjA3IFBN
DQoNCi4uLg0KDQo+ID4gK3N0YXRpYyBib29sIGFkNDY5MV92b2xhdGlsZV9yZWcoc3RydWN0IGRl
dmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgcmVnKQ0KPiA+ICt7DQo+ID4gKwlzd2l0Y2ggKHJlZykg
ew0KPiA+ICsJY2FzZSBBRDQ2OTFfU1RBVFVTX1JFRzoNCj4gPiArCWNhc2UgQUQ0NjkxX0NMQU1Q
X1NUQVRVUzFfUkVHOg0KPiA+ICsJY2FzZSBBRDQ2OTFfQ0xBTVBfU1RBVFVTMl9SRUc6DQo+ID4g
KwljYXNlIEFENDY5MV9HUElPX1JFQUQ6DQo+ID4gKwljYXNlIEFENDY5MV9BQ0NfU1RBVFVTX0ZV
TEwxX1JFRyAuLi4NCj4gQUQ0NjkxX0FDQ19TVEFUVVNfU0FUMl9SRUc6DQo+ID4gKwljYXNlIEFE
NDY5MV9BQ0NfU0FUX09WUl9SRUcoMCkgLi4uDQo+IEFENDY5MV9BQ0NfU0FUX09WUl9SRUcoMTUp
Og0KPiA+ICsJCXJldHVybiB0cnVlOw0KPiA+ICsJZGVmYXVsdDoNCj4gPiArCQlicmVhazsNCj4g
PiArCX0NCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogTXVsdGktYnl0ZSByZWdpc3RlcnMgaGF2
ZSBub24tdW5pdCBzdHJpZGVzOyBvbmx5IGFjY2VwdCBiYXNlDQo+ID4gKwkgKiBhZGRyZXNzZXMg
dG8gcHJldmVudCBkZWJ1Z2ZzIGZyb20gdHJpZ2dlcmluZyByZWFkcyB0aGF0IGNyb3NzDQo+ID4g
KwkgKiByZWdpc3RlciBib3VuZGFyaWVzLg0KPiBXaGF0IGRvZXMgdGhpcyBoYXZlIHRvIGRvIHdp
dGggcHJldmVudGluZyBkZWJ1Z2ZzIGZyb20gZG9pbmcgYW55dGhpbmcuDQo+IEl0IHNob3VsZCBh
bGxvdyByZWFkaW5nIG9mIHZvbGF0aWxlIHJlZ2lzdGVycy4gV2h5IGlzIGl0IG5vdCBlbm91Z2gg
dG8NCj4gbWFrZSB0aGUgbm9uIGJhc2UgYWxpZ25lZCByZWdpc3RlcnMgbmVpdGhlciByZWFkYWJs
ZSBub3Igd3JpdGVhYmxlPw0KPiANCg0KWW91J3JlIHJpZ2h0LCB0aGUgY29tbWVudCBpcyB3cm9u
ZyBhbmQgdGhlIHN0cmlkZSBsb2dpYyBpcyBtaXNwbGFjZWQuDQpyZWFkYWJsZV9yZWcgaXMgd2hh
dCBnYXRlcyBkZWJ1Z2ZzIGFjY2Vzcywgc28gdGhlIHN0cmlkZSBjaGVja3MgaW4NCnZvbGF0aWxl
X3JlZyBhcmUgcmVkdW5kYW50IGFuZCB0aGUgY29tbWVudCBpcyBpbmNvcnJlY3QuDQoNCg==


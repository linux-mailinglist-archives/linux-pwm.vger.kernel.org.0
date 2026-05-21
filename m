Return-Path: <linux-pwm+bounces-9044-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP3gCl3uDmqwDAYAu9opvQ
	(envelope-from <linux-pwm+bounces-9044-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 13:37:01 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3965A41B9
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 13:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E21CE301CFA7
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 11:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1CE3C342B;
	Thu, 21 May 2026 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VaLUMafZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF633C2787;
	Thu, 21 May 2026 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779363187; cv=fail; b=lb/I826eurKIQeT/a/7ijUa1Qfl/eo4eo2NNV3A7vMYjJxcjAv9GIZ5F/XLUKtF0Nkm/5gwhO1jJrsAnwhwWZxDsdDOaClL+hXb7ANwzvm1SRhXile7KqgbKls0d4HV3UYchvn83KKTO7S06Im2OF+/wEWSuOrFxY89DBPP5RJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779363187; c=relaxed/simple;
	bh=mnwG0l0uCvo7k2x0F6LIJICdcQZ1ZaugsTphy8RssP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nCtCZrGS6oWwRl2xpiyW/bC2i1Ut5sGn9VewcK79WIKSAeib9cynHcFDlgOXK5YXXZLFjPvnl5X5CXqOwvBY26uVBXisZPJXXJ+ZWSnZ3Q/WLlK2RgLypY37ethadmQXD0fhZP3tLDWgtgLBUPf1kwZxQr/FzsIgPa3QmveRnCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VaLUMafZ; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LAKd7C3874383;
	Thu, 21 May 2026 07:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mnwG0
	l0uCvo7k2x0F6LIJICdcQZ1ZaugsTphy8RssP4=; b=VaLUMafZooHAACoQcDfHG
	Sy47lOIAGI+mqDUdKh4L1CndWOnlLLDiumKljqkmZNnjEve+oqCITRewRdtkHBBz
	eYpxiUdkyOlREAHOnUxyqtF7JI6Q9sfsr+rzuYWuyBh6xIrHO6OzJ7wjkewepe2/
	0cHtZrWQ98uUa/jpCbAMecs66Kh49NyJN25rw4SELN3QiLXU0v6PVcV6KPFLJbTN
	KqB0gFXH/GoKzv78H5fHERE7bVGmP7jDXlKTl+j1xGYeH2JqfAaVtkBcivrHVFRG
	8h0TLvCJAT9vG+zfWKckzj8aaVpguxuraOYBqBBNk/v5Fyl4+nY+40I6xn544y1S
	A==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010041.outbound.protection.outlook.com [40.93.198.41])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e92pe6620-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 07:32:46 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpaGVwcc6+DzLsSQazLlf+w2ZOqM/evUcb1qB2szcCcYlnmYUeG1HrCMW/v0eA8ZNHrpybYoFA1WsO4tvXGfKNjDo0B4haZq4+kchIEY0ZZoN1QOyo3RVYq9+Bqr2e6TXId6Wn2gKQk5DKUcZ8SixqsvTRm7Mp8uNHMGRpcMeQ6JWuHVIovn7bXDHWhJc0XwrMDiydPCSRtRLbij3Aig3eaKjRmuoAHgDVJK6U2WGGXkKu2caKt/ymWansq1AS5a1kpqmn4HfR3Jt5Qdl6jh3TySAlHZ7CmW2Kn7Ps2Oim9XEg9xHwlgQBjV402wVeOqycsvuHEpV3pwkv6d6WSoqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnwG0l0uCvo7k2x0F6LIJICdcQZ1ZaugsTphy8RssP4=;
 b=L4rpSQOxPpT7maR7FtRlLfbbDbRSODtFad4fdFkWQbl4pePN0Y6F+wg7u0GWJd49S8nVdS1Y1w5IoLrQQ/UzR/MDuF0DV5OWWdjJMgIlK3Me0cUEMmSR8L1UG11ROeBrv8x8U2qCHDO2td7S5heQwm887unj+XLfRseBp5BJ6LlHqXnBWbm+a6jIiYG8ADDKfBO3yBv4EAmKeYRGFWHust2CPoGmc/m+TF9JgGoalC5arTiwsDyB1urx9SySHel+q41ypxIEdVIC+VyA802P4WBDCejZ9lPPusmhc6+dJJIs8WhdjkcQuTZX2lE6sM6mbjExZCDmTTUqj1swroknsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by CO1PR03MB5730.namprd03.prod.outlook.com (2603:10b6:303:9d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 11:32:43 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 11:32:43 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
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
        Shuah Khan <skhan@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v12 5/6] iio: adc: ad4691: add oversampling support
Thread-Topic: [PATCH v12 5/6] iio: adc: ad4691: add oversampling support
Thread-Index: AQHc54ntIELVSeZPQkGQQYBIis0q2LYYUh3A
Date: Thu, 21 May 2026 11:32:42 +0000
Message-ID:
 <LV9PR03MB8414CA3DB26235605C9323E5F70E2@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260519-ad4692-multichannel-sar-adc-driver-v12-0-5b335162aa51@analog.com>
 <20260519-ad4692-multichannel-sar-adc-driver-v12-5-5b335162aa51@analog.com>
In-Reply-To:
 <20260519-ad4692-multichannel-sar-adc-driver-v12-5-5b335162aa51@analog.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|CO1PR03MB5730:EE_
x-ms-office365-filtering-correlation-id: 45d9dffa-d63f-4877-2712-08deb72cac4d
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|921020|38070700021|4143699003|56012099003|18002099003|22082099003|11063799006|6133799003;
x-microsoft-antispam-message-info:
 qn+CmYGkVLJmc/FpgDaIDQ6pp8s1FbQHxAkqen0qHabPT8OC+cIbtxgl+QnixZXVQ6DaiZcFlur5v2kQ7Co7VF/7db+WcyfWt+rtLcC67tzof75cwAOX9QwRCNJFsNr1fijdsZFFKZMGGwU5OcoJlE10rFlPzYRnfNG80wu54Ze0zPY5/zRzy57LEZnML3rXJddsYQ2t9guMajHH1brPJWGu8oM6nJkpaBs1C/423ru88wtwitqtcXohFLVA5a0gAz3TYwMX28QUr1dizV2GeqonS3YF/F9sZ1x5+IVPRS/B8zHGNXxt14w3W9OWLq8c0CWdIHOatE/lpQxureO2FlPlVekfYO7w+sTZi5UpKyQ4M9d+3IdYKMBzkfuxo38izmkJ06rM8v8gpyhnrZ945QZt8EyWAbJqv5b2ZS7k9IInhKSJNV9vK+BfWFCAEMMqmD8yVGFPdAcqtHvRC3LJ2+Xxyqx0+XcqPlW9YGZEZMSkGq2qaBs3mciUoLvieYgB1yrmzSfxoYklJEDmtC80UACIUixUO85zu2yAj9Jo/by0z7auCAzqB76HClALlmEVgWHfqPoGPpNglAl+RRWbCbFvTm/kD8rEKUwf+250ykHIxfTTykWBOwtsJBNC+knw+NQ6iPuJOBoFUsrB2yLPCsGahrVLGYYJZYEvMnl3N1ndD73Top8o8arZa0bfCRQE+I6E3LNwtWFVtPiG6MaA20MRhnrMotSUJkEh4R/Kax0fOM8snX4lf37Gb/eVD3eWabPw8kkFgGdFvnBVSyc1fQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(921020)(38070700021)(4143699003)(56012099003)(18002099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R3lBMHNVVGhKS3ZVcllGQWVldVJobTNzeGwvN1lHSThyNzZ2TS80dnpJZFM4?=
 =?utf-8?B?Y3JSUzRkUEczSDdGK05qdi8vRnZHdXdpNUVOSjU2dU9SZ2pEaTI1d0tiNFUz?=
 =?utf-8?B?Qm5WUWxia2NRZXcyb3ZuOUtrQ1UyN0JnMXBNLzRrTzBUbDVvZ2NnelpEY2Rx?=
 =?utf-8?B?SWFIR2ROMUMvRlNGOGg3c0ZCTk0yR21ZbnRZZ1ZrYXBRbDV1czBoSXNML2dp?=
 =?utf-8?B?TUZvenJmemFaV3BWVUNSeWZ3YllQOGJZdXZXeEJtcnUxZnJPQUs1bmpzYnIw?=
 =?utf-8?B?T2hyTWxTT3BTSUJxazQ2UTQyK0FGVTVpV2c5VFZBUmZkeDEweXR0QnlZS0di?=
 =?utf-8?B?YVJHVGpXL09uNFQvakdQbWVQVE5KcDBLTm1OTGtnN0hndU5oVm5tRzhNQ0M1?=
 =?utf-8?B?MXJjWWZCQzgxWVZqZ3BQa1E0UnJoeXNJdjQ3TnlDaUJjZ2JrN2dGbTJ4YU9U?=
 =?utf-8?B?SVEra3hGc0pBR0Zwc21DNmRRU0lOWVkvZldUYXk4Vkg3ZFJhZ2ZHUDJ0eEhN?=
 =?utf-8?B?cGFudkpBaEV5NnJHL3dkdFNxL1RlM2JvZWt4eVJOSUpKVGd5aDJwM29Mbnky?=
 =?utf-8?B?VEpMS2p3R09sQXdTT0hmZzdxWU4wY2Yrb0VCNHg3MXdyTlBpbm9JcE5JU1Qx?=
 =?utf-8?B?RmlCbXhnaVM0YUVTNmFuOXJJOE1vZVUxOU9pK0t6NzVwSzREbS83S1I1Vmk3?=
 =?utf-8?B?RlVZYVdieHFBRlIwdHFaWWpaNXlZNUJ0ZGR1aEcxa09LUzJYZkVwNk1CaEkr?=
 =?utf-8?B?MDZGbGRoRC92ZTlIUDJyYWdsb0pnOWo3SVZWcVF5eXhlYlN0TEpOM1dQTW1E?=
 =?utf-8?B?dTVCQWdBTG1lbGlRS1dOTXBoS090R2J4Y3BrZkU4bjVsVSsvc3lRaVl2aDRC?=
 =?utf-8?B?eWV0Mkphbm15c2c4OEc4aFF3NG1YQTNtYUF4Z1UvT2ZpWmRMNXVOUkh2L0hm?=
 =?utf-8?B?Umlld1N6cmt0MVdDTDBjY0UzdTZmNTRKSHIzWkN3aVpuSVkzaFFoM2xtZzF6?=
 =?utf-8?B?NWJ0WGI3cENsTFpYK3JiTDNWdzYwRFlnL3IrUHpScmpaUnFzemxNOEFkQXVk?=
 =?utf-8?B?bDJxTWYxUW1ZYWhpS1JuU29Cb09UTm9RTUtpL0JQcENXRk4zMEphR2VBczV1?=
 =?utf-8?B?bHVJR0NONENmdy8xN2ZHWVQwYzFyNk16ZEVSNmx4aHVPUW13bHlUQnV6RnUv?=
 =?utf-8?B?YmFYMEhGVEhkUytha25ZQTdvMkVHZnpISTBqUTdWSm9UTkxjbHM3aThjaW5t?=
 =?utf-8?B?L0FiWTF2ZzNTMlhXSEhLYkhSb01oNUZLZjdoV2l6Y1R4M1VUQ0dWSEZWdDJH?=
 =?utf-8?B?MERodjVaSXJ1TU1FS0ducDh4Vm9Ra0pIVDlHc1doOWlGNmxNYTJnRDdDTjc4?=
 =?utf-8?B?QTRBVDAraVJBQzRRTEF5czJSejRkREJIVkJZTUhobFd0cm54YlFKOVN0VUUz?=
 =?utf-8?B?MTRydGpJd0E5ZC8xWjRlS0lYRW1rcTVrYmZVeDg3bUhoRU5vWVgyVUc1azB0?=
 =?utf-8?B?a0gyUnZjdnRQL1ZacVJQMkNjcDVTbzNLRWZtT1ZYWlNXSHBSZlQvZnc4bk52?=
 =?utf-8?B?ZFFSRU1WREkyT3U3RE0wak9KelQ1dkxBOVZGeHd6THFIYjNzQWRlbnhQZDl2?=
 =?utf-8?B?RWkrNkRBTzJlSHk0UndrNGZvamxJUDZTNmlibk1OWEM2dDlqYTI1S1g1T2R0?=
 =?utf-8?B?WVJkeE1PdGo5OUx1Z1BpM3ZlU1RWTG5PdWRkM2pIV0xJSHpiUlpuWXh1RWlF?=
 =?utf-8?B?RFFhSW9MdDZoUEkzK3R0UmR4RzFCQWl1NlNPaW5PZjZYc1k0NnFrU3RYN3Zo?=
 =?utf-8?B?UlN3akFTR1FBMGNIODZYOW9sSzgrOExvV3FrUEhmcFJhWUxINWpONFlhTG1X?=
 =?utf-8?B?UlduZTlPUVVMbFl1SE9ERndiSi9tTVcwWWxOTlpaTnRlSjhpZVJjZFc4bTBn?=
 =?utf-8?B?ODZDU0JPandYQkgyNXRoa28xUGZQODBSVnNJaXdkdUo4UkNzRGZHNnBscmNZ?=
 =?utf-8?B?SGliQUtxVWxkRTQrNkFuOGx1LzQwOTVpa3RsS0pBOExhZTR0cmpENGZYd0la?=
 =?utf-8?B?WUpYMm9OMjk4elpFUVFtQ0QwcEFJU2VGc3lhYkh4eDEzNHJIZFdESXEzQ0lI?=
 =?utf-8?B?Wmx0RTlmcWlLbHA4MlZDelRBYzVRa3IvbEtZY2xHQkdBa244YU9QRWxxQTVO?=
 =?utf-8?B?bEtsYjJuUWp5cGVMRXpiemFOeXpZQ1JxTGZHOWJLTURQcWYrQXR0cVNBS1Mw?=
 =?utf-8?B?Q0Z2aDN3U3oxazlPV2QrajBCY3VtZUJCVVBFeTViUXAzUVlIMm0rUVh6L0pE?=
 =?utf-8?B?K3E1RUVCeHJMMHNPK0EvVUcxZlNYaFpVNFVoZEFIWmtlTzZKWVpnU3lnd096?=
 =?utf-8?Q?bu6CQ43ifHcgm//M0UFH7qqqP8uVvnYWaru5XBat+7b7U?=
x-ms-exchange-antispam-messagedata-1: yJRr7YhYGKZjbQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	loQSKRSNXMl5HE8bEcYfIe0+KMCPnczSuWVOL61YASX+JnyvvhqBaQgKQ1/SIT9VV4oaOoLQa26vbSNWKhfqm/1kTm/w9uaSdXEmSkgyo1oVBRurVKlUWq9WsJsHeSoWSEl80Wupgluc1AXEqk4M0QURJIIny0qiQW5svApDOG5+echd7hc21K4WaWxfAWz9DaKHPDE6ZVWXerWUeKGiER2Jw4/15ivgXlKw9GjcPXPWgXW049hznGOILSEhHGjbUl4wKA1mZxqcDIL2E+aIs1ZHbN2mn6F+3DUG8h788IsNeYneCptOPwqpglsQnT+OMpzKUpeW7Q2wy1Ckqkp1hA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d9dffa-d63f-4877-2712-08deb72cac4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 11:32:43.0006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iwPaelmAejcUIQLQKX9mVpSyD6QdONxbZ54VzwDsW+pKeIs7QbSDGaTUAFNdYzgxqtNhSjZqdDqkoW9iSL5IEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5730
X-Proofpoint-GUID: JClRboIbO4OgvUaDpfZ6giCWJ9TDyurj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDExNSBTYWx0ZWRfX2OdfmjDTw1As
 N2t2D+snUUbaCx9HN+nsM+ssYo6Z+F7mvPCbNnmCqeMVp0Hgw27308JMO989X9f1VQqTUW6jpLA
 yPixr+0JzIYG8fYVWAi4Tb72UHOksCPv3+MXpyndTwbVl+HGjiQKNc6iuIUlHPW+80gbB4hA6tz
 lTxJVUDWs9ih+u6tN8ptdOaUj88IILINKV6uzieBGKrVX7mkaxc2It2tKuCaZlJthkkOMX2oy+1
 tLraL8mZSzUsdNdKewRdzyDC3wt1Li+t03zmAOBnUgkK99jhe50T4GWIwa6xVRer4b5NrhknZCo
 7Qkf7CSlAZs57L0CqIAbA71pCSz2fVIv3myr/WsUMaieZlgRi05HzwnjOKeUgh7MdVCfEkxLlIm
 hPwuazg5+Gwjzo9jf6JhHHfSpgzD7xa8F2IbkeOXkXPqTWYCcdU3Kgt/Ea6kFehwGDBiUw0a9kB
 kI6qnSB6OuqHfwXaKBA==
X-Authority-Analysis: v=2.4 cv=RcKgzVtv c=1 sm=1 tr=0 ts=6a0eed5e cx=c_pps
 a=GhmKEtzeB3JP3t09wzqP+g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=VwQbUJbxAAAA:8 a=-KGTGPKkfED8wFohFEkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JClRboIbO4OgvUaDpfZ6giCWJ9TDyurj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210115
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-9044-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,analog.com:dkim];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7D3965A41B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSYWR1IFNhYmF1IHZpYSBCNCBS
ZWxheSA8ZGV2bnVsbCtyYWR1LnNhYmF1LmFuYWxvZy5jb21Aa2VybmVsLm9yZz4NCj4gU2VudDog
VHVlc2RheSwgTWF5IDE5LCAyMDI2IDM6MjAgUE0NCg0KLi4uDQoNCj4gDQo+ICsJaWlvX2Zvcl9l
YWNoX2FjdGl2ZV9jaGFubmVsKGluZGlvX2RldiwgYml0KSB7DQo+ICsJCXJldCA9IHJlZ21hcF93
cml0ZShzdC0+cmVnbWFwLA0KPiBBRDQ2OTFfQUNDX0RFUFRIX0lOKGJpdCksIHN0LT5vc3JbYml0
XSk7DQoNClVuZm9ydHVuYXRlbHkgZW5vdWdoLCBJIHRoaW5rIGEgdjEzIHdpbGwgY29tZSwgdG9v
Li4uDQoNCkhhZCBhIGxvb2sgYWdhaW4gb24gd2hhdCBTYXNoaWtvIGhhZCB0byBzYXksIGFuZCBz
ZWVpbmcgdGhlIHNhbXBsaW5nIGZyZXF1ZW5jeQ0Kc2hhcmVkX2J5X2FsbCBjb21tZW50IGFnYWlu
IG1hZGUgbWUgaGF2ZSBhIGRlZXBlciBsb29rIHNlZSBob3cgdGhlIGNvZGUgY291bGQNCmJlIGNv
bW1lbnRlZCBzbyBoZSB3b3VsZG4ndCBjb21wbGFpbiBhYm91dCB0aGlzIGFueW1vcmUsIGFuZC4u
Lg0KDQpQZXJoYXBzIGhlIGlzIGEgYml0IHJpZ2h0IGFmdGVyIGFsbC4gSSBmb3VuZCBhIHNlY3Rp
b24gc3RhdGluZyB0aGF0IGluIHN0YW5kYXJkDQpzZXF1ZW5jZXIgbW9kZSAod2hpY2ggdGhlIGRy
aXZlciB1c2VzIHJpZ2h0IG5vdyksIGFsbCB0aGUgY2hhbm5lbHMgYWN0dWFsbHkgdXNlDQp0aGUg
QUNDX0RFUFRIX0lOMCBmb3Igb3NyLCBhbmQgc28gY2hhbmdpbmcgQUNDX0RFUFRIX0lObiBmb3Ig
b3RoZXIgY2hhbm5lbHMNCmRvZXNuJ3QgcmVhbGx5IGRvIG11Y2guIEFuZCBzbyBJIHRlc3RlZCB0
aGlzIHNlbGVjdGluZyBib3RoIHZvbHRhZ2UwIGFuZCB2b2x0YWdlMQ0KZm9yIHNhbXBsaW5nIHdp
dGggb3NyNCBmb3Igdm9sdGFnZTAgYW5kIG9zcjEgZm9yIHZvbHRhZ2UxIGFuZCB3aXRoIGEgMTAw
a0h6IG9zYyBmcmVxDQppbmRlZWQgRFIgZmVsbCBhZnRlciBhcHByb3hpbWF0ZWx5IDgwdXMgd2hp
Y2ggcG9pbnRzIG91dCBib3RoIGNoYW5uZWxzIHdlcmUgYWN0dWFsbHkNCnVzaW5nIE9TUiBvZiA0
LiBQZXJoYXBzIHRoZSBPU1Igc2hvdWxkIGJlIHNoYXJlZCBieSBhbGwgYW5kIHRoZXJlZm9yZSB0
aGUNCnNhbXBsaW5nIGZyZXF1ZW5jeSB3b3VsZCBhbHNvIGJlIHNoYXJlZCBieSBhbGwsIHJpZ2h0
Pw0KDQpUaGUgdXNhZ2Ugb2YgaW50ZXJuYWxfb3NjX2ZyZXEgYW5kIHByZS1jb21wdXRlZCBmcmVx
IHZhbHVlcyBkZXBlbmRpbmcgb24gb3NyIHdvdWxkDQpzdGF5IHRoZSBzYW1lIHNpbmNlIHRob3Nl
IGFyZSBzdGlsbCBjb3JyZWN0IGFueXdheS4NCg0KV2hhdCdzIHlvdXIgb3BpbmlvbiBvbiB0aGlz
Pw0KUmFkdQ0KDQo=


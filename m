Return-Path: <linux-pwm+bounces-8833-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB1GM7B8/Gl0QgAAu9opvQ
	(envelope-from <linux-pwm+bounces-8833-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 13:51:12 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 438044E7C12
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 13:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA4803043FC3
	for <lists+linux-pwm@lfdr.de>; Thu,  7 May 2026 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5D63EC2EF;
	Thu,  7 May 2026 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WNEo8Kdc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C33CBE9A;
	Thu,  7 May 2026 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778154601; cv=fail; b=CvXnLfiESCZxMofa0N4W5YLE6cavb+w52L3zdhZRztvuZ3WJNRyxenT01LfenGGUJy8dnasXV6tpamtd95ADwGwn2dxx0gctB8TiMaM+Fu5xmsJ5JTrX2KFb1natn9U3NGD4+jXrP7mfNb3wpQHctB7XlKI12VYyc0W6yZRr7rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778154601; c=relaxed/simple;
	bh=Hs4rvs7PvHXxaYh1nYUHoLcZlnvzjIVjmJb76wAHGho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TIERtau1QrjM02Gz3uz5qUUURnS2lZuP0b1B9uUQYTSqoVoRVLygAyaP6rX5KcvSFZJuEhJLvVynlSkDfOvSEsJxajqsJYFtDIs3rU15+hjfCm3QJsmiJHlm8w0r2ogXwBP51EjmFpdFTFiPryqtlgkMpA9EKp+sqYFqcbCk5ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WNEo8Kdc; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647AaoXU400366;
	Thu, 7 May 2026 07:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Hs4rv
	s7PvHXxaYh1nYUHoLcZlnvzjIVjmJb76wAHGho=; b=WNEo8KdcyoDqowH49yXh0
	MczU3SDvWUfapp4xadPn95NJsYg8u//AD9YavhYQ5g7rWAanSyh3w8D0hVgu0tE7
	GXAZ63l76HQGyU4KFEA6WmN1cxucRQodkpHbxy12u3CSpc1HLZaJMi/17ZMt4c94
	2ihZkbrEqIqAsyGyYfiWsZnVguKlWTOGLjKuh6bNQnYla0/2TwzORguIyLDY7lR2
	p834nKejJUhTwW9tFOpW5jE3xg8clA+ljtKwNsIg8hOUun6D66D+/OG/zOE4cVn+
	mh8/FWwGfFUx9rqzySaBK6aFqRmPHn5eT/HWyMHhJjmQw8x6w00jCtxM/zm+blJZ
	Q==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dyu7a72ua-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 07:49:33 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHZSPhSYBi7oSZpiPGXjyF8z/SEnr2+72RRRzflzTSA0GjcZq49PljuSwQSoVvl4mXM8rx0nAyXLGC1IKiTzi7hAg8X/okNsp/9Yjh4NWN+Z2qbSilNfJKW1cTR1JLISLE1U4IZMqMgO1pqPWew/AT1kwp/BjzmU7v9uLjcKAWpyXbA1DZJZdrasjZntzMmHVYVKNABn/UUttlRC4OWZk1bQoHYtE4CHST5D4sae1IFIYmJ9Udoz3ZxIw9lG+AFKOeypfKAEXxzmYbJtTW3kaGMmOn1lHDHtlJk0DzkuIlisLBy/shRxCA/xgsNDln2r00yi49rLjrX/0JZl9YHAFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hs4rvs7PvHXxaYh1nYUHoLcZlnvzjIVjmJb76wAHGho=;
 b=dT0qYm4nh998+jIbSqCx/r0s8WdyoL7AUgtBWdb5A6ph7reGE6A46gKJi8u0Lw7ZEfcedyPlgimKcziEb3gYS9wSvTGNtXSa2XmN7CZCXlqNyX7CbudC/PC9WWVFhppeHFGgoudQmV99Hv0Ulv8ThVjyRrnEiUyL7C/gtB9YwXFH8JF3DmkpBKiMd+S9PBx1JRWn/fAF0ZZwZIh2zoXMH5g0yJKVeoAi5RWNI60bpr+ZnBedWIBVAIFx1/7vEAU92/Vo7Mli15QE3a08YGe7FLGkwEf6MQcH9oaoKJoW5kevVwix4PpZxO6S1/b0UWowsHUrTYMtkSFSaqOfg3XRPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by DS7PR03MB8069.namprd03.prod.outlook.com (2603:10b6:8:250::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Thu, 7 May
 2026 11:49:29 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 11:49:29 +0000
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
Subject: RE: [PATCH v9 4/6] iio: adc: ad4691: add SPI offload support
Thread-Topic: [PATCH v9 4/6] iio: adc: ad4691: add SPI offload support
Thread-Index: AQHc2Ip7GFfgCljdvUysP75/UKS6EbYCetZw
Date: Thu, 7 May 2026 11:49:29 +0000
Message-ID:
 <LV9PR03MB8414E7E034F79900A6595750F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
 <20260430-ad4692-multichannel-sar-adc-driver-v9-4-33e439e4fb87@analog.com>
In-Reply-To:
 <20260430-ad4692-multichannel-sar-adc-driver-v9-4-33e439e4fb87@analog.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|DS7PR03MB8069:EE_
x-ms-office365-filtering-correlation-id: f4e5a40b-8623-4f91-34a2-08deac2eb28b
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|921020|18002099003|56012099003|22082099003|3023799003;
x-microsoft-antispam-message-info:
 xUXFt44V9j1L3qOq/9+rtAPDGFcs3owJLs+26VGJkr/iBVXhcLd8reuCjz97mlLw6/+AY3y7/9Hov6fvPqWAiMfxDq7z1vMUg3Qc1v0iIE/xiNvuJILBJZT22onw7bNHDj4WYvdtXUKCy+uDVDQY6OZGM5x9I/jW/CeX+KARPyNfDmffhbQLsZt9REPNVS/jtKT+lZg3GIUwLOmr50+dE6lIbcmVvdWWhnm4a/RLfqZKEMZ3uYBq3X2gFmA+sNjwx+/v5OJHA9RToCcTfU3qFsQT0CYyAZrHagrRlYAkfZotqWCAicUalMx5sZSwXsGoAHiqilGQ6pUl+VrexOZ804cptXAi9jHmOFxYJDlbpC/EN1mumYgZUO8gCmzjARwOuc6pq/ZFbsYqeGnqFN28WCbRVLGuknb68nkBsWJgPoa/fStwiBlrWyHqYN1a/r25i7U/kB0CKfoiDIfb6wxKlh0glZpE4qBklqGuPVVn94HZZ64p9iWrA3m8hzXGE9UZ0wg39/HC+d4o9qJK9foRkT3YNbebCxAKBM5MpMx3z/bzBVQyiJRv1v00LFkEH9549zGV2Fjlns59yYuz71hTuOzSW5uWmZen29tWN7J0rtslCOYy8iRn/yq8kcuVuZ+azGLnfWYGTamIUI/RWy+ph7vDtdb7VkhWi+9OrlL9MZtSdaG2hh2XqBI925z2nOtljQ69zxVEsQz+dH4oEAqCGEfTTsSLJFDwBAl8+6JJWT2cpz6XvlwtIUqpgBoLNb85cSZD18MO7dj+sJMGvWpJ0A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(921020)(18002099003)(56012099003)(22082099003)(3023799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFRuSm5pYnRVZTh6N3VGaXRPUmpicnhBME0yM2FWb2VrZVRSVTBJTFl3bHVi?=
 =?utf-8?B?d2R4dnZGQTlGcXhMemlnamFEdVd6Z1ZEeEIvY0hvaDdwZy9qOVg1dDVJTFN1?=
 =?utf-8?B?NnA3VFVXYzRyR2graWFPdFJMbjRkZUE1VFY1bmI0MXB0RE1XdnptRmVSRlRq?=
 =?utf-8?B?V3ZTU2E0amdjbTF3TW43U3FrVlBJVDdPekZKYmo1dGRzc3Q4TVp2aDYwbk40?=
 =?utf-8?B?cVFMaVlZbE1PY041ZEdQU3orc2MrUjZEMWhNNlNUZC9iR0N3c0FMVXpEVXZm?=
 =?utf-8?B?eTdMWEVOTnFOK3RYRjNZdUxpQlZyNGt4anVqY3UvR0JzWS9KSjdrZnFQQ2Vk?=
 =?utf-8?B?K2d5Tko2aEJSbUFhOFBXTVlOMmxONzUwMm5MR25tcjNqYWdqQWl0THdiWW5G?=
 =?utf-8?B?S2FDK20zTGwxN3lTUm1kSzYrdElOT3ZoT2o5VUxUZm5ORnFRd29kMkJnZWx6?=
 =?utf-8?B?bEpvR2NwT3lBa20xTkk5Wm90T2Fic2sxT1cvSi92TzNYN0FkZTlZUWFTbWw4?=
 =?utf-8?B?Uk54Y1pJcWdYVWRDQlM5M1Jobk5BZWhKVGdzdmJPTExFckRVV0o5NWJxRUtJ?=
 =?utf-8?B?Z2szSmh4OGlTZ1VGT0pLUDVzUm9xVmEyOGJzSTk0NFE0WGdPMUxJRFZHM1Vw?=
 =?utf-8?B?aFVVQmRnakIxMHpkd0QzZGJDSWhTOUROR2h3Qm93dUtCR0puMkYxaXprL0Rj?=
 =?utf-8?B?Y3QxdnBURUczNHZSQnNHZXJGZDlZREFNT1M5dmp1Nm9oTEIyK2RxN3lUeTdQ?=
 =?utf-8?B?V2N4MVNtODkyYjNvWWdjSlpNa1NBRTByTlhqSkpxelluY0tvTFdqQmViZE84?=
 =?utf-8?B?aDBBeTZpUU4yWm9UT1VBWVJPbjFnOGZpd3RBYnFtalZOOTFhZGpFSVIwUHZo?=
 =?utf-8?B?K3dqTGZOUnJlMGwxZUFNZXJLQ3RVdEZObFdSQ05yRlVNc1R5YklhZVQwazBE?=
 =?utf-8?B?Z1NqUUdjWld2YU1paTFrNmZWdHc3UHA0UlowWVlOSjN0Ny9pSysyUVRrMnFH?=
 =?utf-8?B?T3BuQXJ4aVJCaTRGWE9VS0hyWE5yNS96YVNKdFhyb3ovZXZrL3JJWTArejhI?=
 =?utf-8?B?TEc5SGFOZFVUMGRUTFA3eXlaQ0dlOC9hTXhBUUQ2cW4wUVgrbjArVjB6Z0Z3?=
 =?utf-8?B?Um15aDQ5NG5mMnI5M3NqKzRSc0VxU09paFFCTGVJZW5pNm5xcVYyTGlpMDZS?=
 =?utf-8?B?aW5TVUpLeElTd0dJU1hTaUttMHdEaTRPd3JWLzRwSG5pNmxVREJWU1h3blRx?=
 =?utf-8?B?SGdFS3Z1UllsRzBzSXRsT3NSUHR6Q2RsTWxvREtsU2hUVzhMTGlQRjdTZG92?=
 =?utf-8?B?R0MyMTdUZU5EbURMK2pKNjBlcXlLUVF1YzJGN0ZEQ0JnQUkvUlVUZWR0aU1v?=
 =?utf-8?B?SVMraTQxTmNvTVpNVlNRN3dhRDhIVGNsVzBmTlA2YlJVWU1jRzZwdlYyRWV1?=
 =?utf-8?B?cm9adG1qdWFjR3Uvc1NhUlVPZFh5SElscjFVcFBhUDVVeVFtYmVuTmxyQnhm?=
 =?utf-8?B?VDNzV3VjVU9LVHcwc254VElnUm40emxUamRuMzU3TjRwUWczV0gxMWRYQ3hX?=
 =?utf-8?B?ejdYQWVkUUpISUlrbHFMRFJ4alJnSHpJdDRtbGxCN3czdXB0TThOaUlTczFQ?=
 =?utf-8?B?UXJCaGtNVVAvN1BRYm1VcHNSQVMzbHY4Qkk5Qk1OdTg2UFpIeG1wU3hnUlVw?=
 =?utf-8?B?MCs4R05sM2Z6SnBQa0VLUmtrUnI1TUtoaW01clVaRkFMR3ZnanZ1YThyY3BU?=
 =?utf-8?B?aFN5MTN2QVdyOXR0Q3VrSU9PSVRmREJTdkJMZG5GSndvOS9KTkduZ2VIYWJY?=
 =?utf-8?B?T1pWblo0S1JtMTMwVWY3RXpXc08yUVAwVEVFcXY0RE82dFhpRUhydjJYUHI2?=
 =?utf-8?B?S2I4eDlaSWdRSCsycXd1S1RJT0dyNTJJdVl1TUw2K3RGM3V2MExZL2VQVFZF?=
 =?utf-8?B?SExkQzFCdzdQc1F5d2c5ZGJCdTh2TFBPZUIzM2xpTVJoallzTkJ3OUo2Z3Rq?=
 =?utf-8?B?Q0hOUFZxU05Bci81dEIzRU9NbSs2eWRiS0tIeGgyc3p5K3lPK1ZpNG1Qd0dz?=
 =?utf-8?B?Wi9qcUdWWDFYbnZtMFA3NkZvSE5PdUlsaUFYaUx5K1lJZk1GVlU4aE5XQ3lP?=
 =?utf-8?B?dG5VZFJSUXJ0WXorTTdjRXJyNGlrL2Rqc0lXdW44UGZIWStDamw5d1FrajV3?=
 =?utf-8?B?L0ZpZ2o4b2E1V2paRXAvRUl0YVBCRW5tNGVqdmlQMXhiU0YyalF4ZkFEZzZ6?=
 =?utf-8?B?dkZobWZva2dWcURMMUR1UTkwQVR5VlJOR3psU2wwK21IMFRteS9GTEpmTEkx?=
 =?utf-8?B?ZUVObWZGaHgwTnk2VnptYm03OG00M0kyUUE3MFZJdDlSTm5vbFI3UT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	oDaRjsze4t9O9wdUVAEYWZyPQnIVFNpjAxiEjI3+7BR0JRbx6p0K4mU9iQ18Ix2epOPAvjuPZiUpxrtXkgzHEGl453G1W/rCmMsqcP9noAuabioYPrsh0yGuZk8PYdR3StPmwqyG6KhAY/uBrmjQDTts7nVWvJDqCyRWOWORtX+ap2bLbb70d0J7oo01UinCn1FV6J1aurbKpbX2lEk85bnyDdy+NzwxnKoIyc9f2YCEhCsfWUOELMo55bUBraxkWb1FcSW6tMIkbiPvWITEI081RAeMR7obpSK9az+FlCTBDoDdqkRtYjeRz38TGqAkrSbigd3Mwn5b7ZLGduZehQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e5a40b-8623-4f91-34a2-08deac2eb28b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 11:49:29.6697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wv6ZbOqCe6Ge4KRRsxmGxfDFRiQavDMzSOml0WfoHQXy8L7yzJygwxVeMmruvv14jzriIhTC29qw+SMXmtIevQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8069
X-Proofpoint-ORIG-GUID: _q8cbcco1cEL1V2OUj24XEz_vobvPFdQ
X-Proofpoint-GUID: _q8cbcco1cEL1V2OUj24XEz_vobvPFdQ
X-Authority-Analysis: v=2.4 cv=caXiaHDM c=1 sm=1 tr=0 ts=69fc7c4d cx=c_pps
 a=uhkaN0mRh0u8fl/99TXUBg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=AEO2Hdu5w86Po1Vu4nAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDExNyBTYWx0ZWRfX6viPY0vWrqGo
 Sk+2/ibn+vIQRdL1HwTW470aMzpBe1VV+v6E1kw1QH0rxH0NEwkuTvaQ0+CzA6ZKqw1K/DF3A4p
 LaxyJ+DqHI8JWwjfBDclND+ehMNU9vRPLZNuTrmFhDs9drObQxsaosjy5BD0BndifVLz3fWcnKK
 9lhWL+HGzLZYGUrgBsER/imPIW/imFTScHlitsgvZVEfj8+V+uc+PkTR893xKZiXqLSmKbfHJPh
 VcXCFQj1WT+9lcZObhqvHz55ETDeziiPIvn8kmrJzf9K7DGX4jxbDKyaNmR1g4JCbbcQObsXk6C
 5oqyw72LU+JafiGE524f3S+dHCevHf/1ZHEt7QvqS8Le9oM8r7poGM6XJENOMndVm9unVahYCmi
 C/qik+k+Yqew3lPmKXj/3pPDEAX7EvokR8BMjmRjG+nWnGU6x8okeQPl7HbRvoLdVEx88NC2GWk
 onk42/pvzxERYDxUpNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070117
X-Rspamd-Queue-Id: 438044E7C12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-8833-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[analog.com,metafoo.de,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email,analog.com:dkim,LV9PR03MB8414.namprd03.prod.outlook.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

QWRkcmVzc2luZyBTYXNoaWtvJ3MgcmV2aWV3IGZvciB0aGUgb2ZmbG9hZCBzdXBwb3J0IHBhdGNo
Lg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJhZHUgU2FiYXUgdmlh
IEI0IFJlbGF5IDxkZXZudWxsK3JhZHUuc2FiYXUuYW5hbG9nLmNvbUBrZXJuZWwub3JnPg0KPiBT
ZW50OiBUaHVyc2RheSwgQXByaWwgMzAsIDIwMjYgMToxNyBQTQ0KDQouLi4NCg0KPiBBbGwgb2Zm
bG9hZCB0cmFuc2ZlcnMgdXNlIDE2LWJpdCBmcmFtZXMgKGJpdHNfcGVyX3dvcmQ9MTYsIGxlbj0y
KS4NCj4gVGhlIGNoYW5uZWwgc2Nhbl90eXBlIChzdG9yYWdlYml0cz0xNiwgc2hpZnQ9MCwgSUlP
X0JFKSBpcyBzaGFyZWQNCj4gYmV0d2VlbiB0aGUgc29mdHdhcmUgdHJpZ2dlcmVkLWJ1ZmZlciBh
bmQgb2ZmbG9hZCBwYXRoczsgbm8gc2VwYXJhdGUNCj4gc2Nhbl90eXBlIG9yIGNoYW5uZWwgYXJy
YXkgaXMgbmVlZGVkIGZvciB0aGUgb2ZmbG9hZCBjYXNlLiBUaGUNCj4gYWQ0NjkxX21hbnVhbF9j
aGFubmVsc1tdIGFycmF5IGludHJvZHVjZWQgaW4gdGhlIHRyaWdnZXJlZC1idWZmZXINCj4gY29t
bWl0IGlzIHJldXNlZCBoZXJlOiBpdCBoaWRlcyB0aGUgSUlPX0NIQU5fSU5GT19PVkVSU0FNUExJ
TkdfUkFUSU8NCj4gYXR0cmlidXRlLCB3aGljaCBpcyBub3QgYXBwbGljYWJsZSBpbiBNYW51YWwg
TW9kZS4NCg0KIlRoaXMgaXNuJ3QgYSBidWcsIGJ1dCBhZDQ2OTFfbWFudWFsX2NoYW5uZWxzIGFu
ZCB0aGUgb3ZlcnNhbXBsaW5nIGF0dHJpYnV0ZQ0KZG9uJ3QgYXBwZWFyIHRvIGV4aXN0IGluIHRo
aXMgZHJpdmVyLiBXYXMgdGhpcyBjb3BpZWQgZnJvbSBhbm90aGVyIGRyaXZlcj8iDQoNCkFncmVl
ZCBvbiB0aGUgY29tbWl0IG1lc3NhZ2UgYXMgcGVyIEpvbmF0aGFuJ3MgaW5wdXQgYXMgd2VsbC4N
ClJlbW92ZWQgdGhlIHR3byBzZW50ZW5jZXMgcmVmZXJlbmNpbmcgYWQ0NjkxX21hbnVhbF9jaGFu
bmVsc1tdIGFuZA0KSUlPX0NIQU5fSU5GT19PVkVSU0FNUExJTkdfUkFUSU8g4oCUIGJvdGggd2Vy
ZSBjYXJyaWVkIG92ZXIgZnJvbSBhDQpkcmFmdCB0aGF0IGluY2x1ZGVkIE9TUiBzdXBwb3J0LCB3
aGljaCB3YXMgc3BsaXQgaW50byB0aGUgZm9sbG93aW5nIGNvbW1pdC4NClRoZSB1cGRhdGVkIG1l
c3NhZ2Ugbm93IGNhbGxzIG91dCBleHBsaWNpdGx5IHRoYXQgcGVyLW1vZGUgY2hhbm5lbCBhcnJh
eQ0KZGlzdGluY3Rpb25zIGFuZCBvdmVyc2FtcGxpbmcgc3VwcG9ydCBhcmUgaW50cm9kdWNlZCBp
biB0aGUgbmV4dCBjb21taXQuDQoNCj4gDQo+IEtjb25maWcgZ2FpbnMgYSBkZXBlbmRlbmN5IG9u
IElJT19CVUZGRVJfRE1BRU5HSU5FLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmFkdSBTYWJhdSA8
cmFkdS5zYWJhdUBhbmFsb2cuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaWlvL2FkYy9LY29uZmln
ICB8ICAgMiArDQo+ICBkcml2ZXJzL2lpby9hZGMvYWQ0NjkxLmMgfCAzOTINCj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gIDIgZmlsZXMgY2hhbmdl
ZCwgMzg5IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9paW8vYWRjL0tjb25maWcgYi9kcml2ZXJzL2lpby9hZGMvS2NvbmZpZw0KPiBpbmRl
eCBkNDk4ZjE2YzA4MTYuLmZkYzY1NjU5MzNjNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8v
YWRjL0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL0tjb25maWcNCj4gQEAgLTE0Myw4
ICsxNDMsMTAgQEAgY29uZmlnIEFENDY5MQ0KPiAgCXRyaXN0YXRlICJBbmFsb2cgRGV2aWNlcyBB
RDQ2OTEgRmFtaWx5IEFEQyBEcml2ZXIiDQo+ICAJZGVwZW5kcyBvbiBTUEkNCj4gIAlzZWxlY3Qg
SUlPX0JVRkZFUg0KPiArCXNlbGVjdCBJSU9fQlVGRkVSX0RNQUVOR0lORQ0KPiAgCXNlbGVjdCBJ
SU9fVFJJR0dFUkVEX0JVRkZFUg0KPiAgCXNlbGVjdCBSRUdNQVANCj4gKwlzZWxlY3QgU1BJX09G
RkxPQUQNCj4gIAloZWxwDQo+ICAJICBTYXkgeWVzIGhlcmUgdG8gYnVpbGQgc3VwcG9ydCBmb3Ig
QW5hbG9nIERldmljZXMgQUQ0NjkxIEZhbWlseQ0KPiBNdXhTQVINCj4gIAkgIFNQSSBhbmFsb2cg
dG8gZGlnaXRhbCBjb252ZXJ0ZXJzIChBREMpLg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8v
YWRjL2FkNDY5MS5jIGIvZHJpdmVycy9paW8vYWRjL2FkNDY5MS5jDQo+IGluZGV4IGMxZTM0MDZm
ZWYxOC4uNTBkODFkODdkNGEwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvYWQ0Njkx
LmMNCj4gKysrIGIvZHJpdmVycy9paW8vYWRjL2FkNDY5MS5jDQo+IEBAIC0yMywxMCArMjMsMTQg
QEANCg0KLi4uDQoNCj4gK3N0cnVjdCBhZDQ2OTFfb2ZmbG9hZF9zdGF0ZSB7DQo+ICsJc3RydWN0
IHNwaV9vZmZsb2FkICpvZmZsb2FkOw0KPiArCXN0cnVjdCBzcGlfb2ZmbG9hZF90cmlnZ2VyICp0
cmlnZ2VyOw0KPiArCXU2NCB0cmlnZ2VyX2h6Ow0KPiArCXU4IHR4X2NtZFsxN11bMl07DQo+ICsJ
dTggdHhfcmVzZXRbNF07DQo+ICB9Ow0KDQoiQ291bGQgdXNpbmcgdGhlc2UgYnVmZmVycyBmb3Ig
RE1BIHRyYW5zZmVycyBjYXVzZSBtZW1vcnkgY29ycnVwdGlvbiBvbg0KYXJjaGl0ZWN0dXJlcyB3
aXRoIG5vbi1jb2hlcmVudCBjYWNoZXM/IA0KVGhleSBhcmUgbm90IG1hcmtlZCB3aXRoIF9fYWxp
Z25lZChJSU9fRE1BX01JTkFMSUdOKSwgc28gdGhleSBzaGFyZSBjYWNoZWxpbmVzDQp3aXRoIGVh
Y2ggb3RoZXIgYW5kIGFkamFjZW50IHN0cnVjdCBtZW1iZXJzIGxpa2UgdHJpZ2dlcl9oei4iDQoN
ClZhbGlkLiBzdHJ1Y3QgYWQ0NjkxX29mZmxvYWRfc3RhdGUgaXMgYWxsb2NhdGVkIHdpdGggZGV2
bV9remFsbG9jDQp3aGljaCBkb2VzIG5vdCBndWFyYW50ZWUgY2FjaGUtbGluZSBhbGlnbm1lbnQs
IHNvIHR4X2NtZCBhbmQgdHhfcmVzZXQNCnNoYXJlZCBjYWNoZSBsaW5lcyB3aXRoIHRyaWdnZXJf
aHogYW5kIHRoZSBwb2ludGVyIGZpZWxkcy4gUmVtb3ZlZCBib3RoDQpmcm9tIGFkNDY5MV9vZmZs
b2FkX3N0YXRlIGVudGlyZWx5LiBUaGUgZXhpc3Rpbmcgc2Nhbl90eFsxN10gZmllbGQgaW4NCnN0
cnVjdCBhZDQ2OTFfc3RhdGUgaXMgbGFyZ2UgZW5vdWdoIGZvciBhbGwgMTcgQVZHX0lOIGFkZHJl
c3NlcyBhbmQgaXMNCmFscmVhZHkgX19hbGlnbmVkKElJT19ETUFfTUlOQUxJR04pOyByZXVzZWQg
aXQgZm9yIHRoZSBvZmZsb2FkIFRYDQpjb21tYW5kcyAodGhlIHR3byBwYXRocyBhcmUgbXV0dWFs
bHkgZXhjbHVzaXZlIGF0IHByb2JlKS4NCg0KPiANCj4gIHN0cnVjdCBhZDQ2OTFfc3RhdGUgew0K
PiBAQCAtMjUyLDcgKzI4NiwxMCBAQCBzdHJ1Y3QgYWQ0NjkxX3N0YXRlIHsNCj4gIAkgKgkJICAg
IHRyYW5zZmVycyBpbiBvbmUgZ28uDQo+ICAJICovDQo+ICAJc3RydWN0IHNwaV9tZXNzYWdlIHNj
YW5fbXNnOw0KDQouLi4NCg0KPiArDQo+ICtzdGF0aWMgaW50IGFkNDY5MV9jbnZfYnVyc3Rfb2Zm
bG9hZF9idWZmZXJfcG9zdGVuYWJsZShzdHJ1Y3QgaWlvX2Rldg0KPiAqaW5kaW9fZGV2KQ0KPiAr
ew0KPiArCXN0cnVjdCBhZDQ2OTFfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4g
KwlzdHJ1Y3QgYWQ0NjkxX29mZmxvYWRfc3RhdGUgKm9mZmxvYWQgPSBzdC0+b2ZmbG9hZDsNCj4g
KwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSByZWdtYXBfZ2V0X2RldmljZShzdC0+cmVnbWFwKTsNCj4g
KwlzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpID0gdG9fc3BpX2RldmljZShkZXYpOw0KDQouLi4NCg0K
PiArCQkvKiBUWDogYWRkcmVzcyBwaGFzZSwgQ1Mgc3RheXMgYXNzZXJ0ZWQgaW50byBkYXRhIHBo
YXNlICovDQo+ICsJCXN0LT5zY2FuX3hmZXJzWzIgKiBrXS50eF9idWYgPSBvZmZsb2FkLT50eF9j
bWRba107DQo+ICsJCXN0LT5zY2FuX3hmZXJzWzIgKiBrXS5sZW4gPSBzaXplb2Yob2ZmbG9hZC0+
dHhfY21kW2tdKTsNCj4gKwkJc3QtPnNjYW5feGZlcnNbMiAqIGtdLmJpdHNfcGVyX3dvcmQgPSBi
cHc7DQoNCiJXaGVuIGJpdHNfcGVyX3dvcmQgaXMgZ3JlYXRlciB0aGFuIDggKGxpa2UgYnB3ID0g
MTYgaGVyZSksIHRoZSBTUEkgZnJhbWV3b3JrDQp0cmVhdHMgdHhfYnVmIGFzIGFuIGFycmF5IG9m
IG5hdGl2ZSAxNi1iaXQgd29yZHMuDQpPbiBsaXR0bGUtZW5kaWFuIGFyY2hpdGVjdHVyZXMsIHRo
ZSBjb250cm9sbGVyIHdpbGwgYnl0ZS1zd2FwIHRoZSBkYXRhIGJlZm9yZQ0KdHJhbnNtaXR0aW5n
IGl0LiBXaWxsIHVzaW5nIGEgdTggYXJyYXkgYW5kIHB1dF91bmFsaWduZWRfYmUxNigpIHJlc3Vs
dCBpbiB0aGUNCmNvbW1hbmQgYnl0ZXMgYmVpbmcgcmV2ZXJzZWQgb24gdGhlIHdpcmU/Ig0KDQpT
d2l0Y2hlZCB0byBjcHVfdG9fYmUxNigpIGFzc2lnbmVkIGRpcmVjdGx5IGludG8gX19iZTE2IHNj
YW5fdHhbXSwNCm1hdGNoaW5nIHRoZSBub24tb2ZmbG9hZCBwYXRoLiBUaGlzIG1ha2VzIHRoZSBp
bnRlbmRlZCB3aXJlIGZvcm1hdA0Kc2VsZi1ldmlkZW50IGFuZCBzaWRlc3RlcHMgdGhlIGJ5dGUt
b3JkZXJpbmcgcXVlc3Rpb24gZW50aXJlbHkuDQoNCj4gKw0KPiArCQkvKiBSWDogZGF0YSBwaGFz
ZSwgQ1MgdG9nZ2xlcyBhZnRlciB0byBkZWxpbWl0IHRoZSBuZXh0IHJlZ2lzdGVyDQo+IG9wICov
DQo+ICsJCXN0LT5zY2FuX3hmZXJzWzIgKiBrICsgMV0ubGVuID0gc2l6ZW9mKG9mZmxvYWQtPnR4
X2NtZFtrXSk7DQo+ICsJCXN0LT5zY2FuX3hmZXJzWzIgKiBrICsgMV0uYml0c19wZXJfd29yZCA9
IGJwdzsNCj4gKwkJc3QtPnNjYW5feGZlcnNbMiAqIGsgKyAxXS5vZmZsb2FkX2ZsYWdzID0NCj4g
U1BJX09GRkxPQURfWEZFUl9SWF9TVFJFQU07DQo+ICsJCXN0LT5zY2FuX3hmZXJzWzIgKiBrICsg
MV0uY3NfY2hhbmdlID0gMTsNCj4gKwkJaysrOw0KPiArCX0NCj4gKw0KPiArCS8qIFN0YXRlIHJl
c2V0IHRvIHJlLWFybSBEQVRBX1JFQURZIGZvciB0aGUgbmV4dCBzY2FuLiAqLw0KPiArCXB1dF91
bmFsaWduZWRfYmUxNihBRDQ2OTFfU1RBVEVfUkVTRVRfUkVHLCBvZmZsb2FkLT50eF9yZXNldCk7
DQo+ICsJb2ZmbG9hZC0+dHhfcmVzZXRbMl0gPSBBRDQ2OTFfU1RBVEVfUkVTRVRfQUxMOw0KPiAr
DQo+ICsJc3QtPnNjYW5feGZlcnNbMiAqIGtdLnR4X2J1ZiA9IG9mZmxvYWQtPnR4X3Jlc2V0Ow0K
PiArCXN0LT5zY2FuX3hmZXJzWzIgKiBrXS5sZW4gPSBzaXplb2Yob2ZmbG9hZC0+dHhfY21kW2td
KTsNCj4gKwlzdC0+c2Nhbl94ZmVyc1syICoga10uYml0c19wZXJfd29yZCA9IGJwdzsNCj4gKw0K
PiArCXN0LT5zY2FuX3hmZXJzWzIgKiBrICsgMV0udHhfYnVmID0gJm9mZmxvYWQtPnR4X3Jlc2V0
WzJdOw0KPiArCXN0LT5zY2FuX3hmZXJzWzIgKiBrICsgMV0ubGVuID0gc2l6ZW9mKG9mZmxvYWQt
PnR4X2NtZFtrXSk7DQoNCiJXaWxsIHBhc3NpbmcgJm9mZmxvYWQtPnR4X3Jlc2V0WzJdIGRpcmVj
dGx5IGFzIHR4X2J1ZiBjYXVzZSBETUEgbWFwcGluZw0KaXNzdWVzLCBzaW5jZSBpdCBpcyBvbmx5
IDItYnl0ZSBhbGlnbmVkPyINCg0KQWRkcmVzc2VkIGJ5IHRoZSBzZWNvbmQgY29uY2VybidzIGZp
eDogbm8gc3ViLWFsaWduZWQgcG9pbnRlciBpbnRvIHRoZSBtaWRkbGUNCm9mIGEgRE1BIGJ1ZmZl
ciDigJQgdGhlIGZ1bGwgNC1ieXRlIHNjYW5fdHhfcmVzZXRbXSBpcyBwYXNzZWQgYXMgdHhfYnVm
DQpmcm9tIGl0cyBvd24gY2FjaGUtbGluZS1hbGlnbmVkIHN0YXJ0IGFkZHJlc3MuDQoNCj4gKwlz
dC0+c2Nhbl94ZmVyc1syICogayArIDFdLmJpdHNfcGVyX3dvcmQgPSBicHc7DQo+ICsJc3QtPnNj
YW5feGZlcnNbMiAqIGsgKyAxXS5jc19jaGFuZ2UgPSAxOw0KDQpUaGUgQURJIFNQSSBFbmdpbmUg
YWx3YXlzIGRlYXNzZXJ0cyBDUyBhdCB0aGUgZW5kIG9mIGl0cyBwcm9ncmFtbWVkDQpzZXF1ZW5j
ZSByZWdhcmRsZXNzLCB0aG91Z2ggSSB3aWxsIGRyb3AgdGhpcyBpbiBvcmRlciB0byBhdm9pZCBj
b25mdXNpb24uDQoNCj4gKw0KPiArCXNwaV9tZXNzYWdlX2luaXRfd2l0aF90cmFuc2ZlcnMoJnN0
LT5zY2FuX21zZywgc3QtPnNjYW5feGZlcnMsIDIgKiBrDQo+ICsgMik7DQo+ICsJc3QtPnNjYW5f
bXNnLm9mZmxvYWQgPSBvZmZsb2FkLT5vZmZsb2FkOw0KPiArDQo+ICsJcmV0ID0gc3BpX29wdGlt
aXplX21lc3NhZ2Uoc3BpLCAmc3QtPnNjYW5fbXNnKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlnb3Rv
IGVycl9leGl0X2NvbnZlcnNpb247DQo+ICsNCj4gKwlyZXQgPSBhZDQ2OTFfc2FtcGxpbmdfZW5h
YmxlKHN0LCB0cnVlKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlnb3RvIGVycl91bm9wdGltaXplOw0K
PiArDQo+ICsJcmV0ID0gc3BpX29mZmxvYWRfdHJpZ2dlcl9lbmFibGUob2ZmbG9hZC0+b2ZmbG9h
ZCwgb2ZmbG9hZC0+dHJpZ2dlciwNCj4gJmNvbmZpZyk7DQoNCiJJZiB0aGUgUFdNIHN0YXJ0cyBn
ZW5lcmF0aW5nIERBVEFfUkVBRFkgdHJpZ2dlciBlZGdlcyBpbiBhZDQ2OTFfc2FtcGxpbmdfZW5h
YmxlDQpiZWZvcmUgdGhlIFNQSSBvZmZsb2FkIHRyaWdnZXIgaXMgZW5hYmxlZCwgY291bGQgdGhl
IG9mZmxvYWQgZW5naW5lIG1pc3MgdGhlDQpmaXJzdCB0cmlnZ2VyIGVkZ2U/DQpJZiB0aGF0IGZp
cnN0IGVkZ2UgaXMgbWlzc2VkLCB3b3VsZG4ndCB0aGUgREFUQV9SRUFEWSBsaW5lIHJlbWFpbiBw
ZXJtYW5lbnRseQ0KYXNzZXJ0ZWQgKGJlY2F1c2UgdGhlIFNUQVRFX1JFU0VUIGNvbW1hbmQgaXMg
bmV2ZXIgc2VudCksIGRlYWRsb2NraW5nIHRoZQ0KZW50aXJlIGNhcHR1cmU/Ig0KDQpWYWxpZC4g
U3dhcHBlZCB0aGUgb3JkZXI6IHNwaV9vZmZsb2FkX3RyaWdnZXJfZW5hYmxlKCkgZmlyc3QsIHRo
ZW4NCmFkNDY5MV9zYW1wbGluZ19lbmFibGUoKSwgc28gdGhlIG9mZmxvYWQgZW5naW5lIGlzIGFy
bWVkIGJlZm9yZSB0aGUgZmlyc3QNCkNOViBwdWxzZSBmaXJlcy4gV2l0aG91dCB0aGlzLCBpZiBE
QVRBX1JFQURZIGFzc2VydHMgaW4gdGhlIHdpbmRvdyBiZXR3ZWVuDQpzYW1wbGluZ19lbmFibGUo
KSBhbmQgdHJpZ2dlcl9lbmFibGUoKSwgdGhlIFNQSSBFbmdpbmUgbWlzc2VzIHRoZSByaXNpbmcN
CmVkZ2UgYW5kIHRoZSBjYXB0dXJlIGRlYWRsb2Nrcy4NCg0KPiArCWlmIChyZXQpDQo+ICsJCWdv
dG8gZXJyX3NhbXBsaW5nX2Rpc2FibGU7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gKw0KPiArZXJy
X3NhbXBsaW5nX2Rpc2FibGU6DQo+ICsJYWQ0NjkxX3NhbXBsaW5nX2VuYWJsZShzdCwgZmFsc2Up
Ow0KPiArZXJyX3Vub3B0aW1pemU6DQo+ICsJc3BpX3Vub3B0aW1pemVfbWVzc2FnZSgmc3QtPnNj
YW5fbXNnKTsNCj4gK2Vycl9leGl0X2NvbnZlcnNpb246DQo+ICsJYWQ0NjkxX2V4aXRfY29udmVy
c2lvbl9tb2RlKHN0KTsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50
IGFkNDY5MV9jbnZfYnVyc3Rfb2ZmbG9hZF9idWZmZXJfcHJlZGlzYWJsZShzdHJ1Y3QgaWlvX2Rl
dg0KPiAqaW5kaW9fZGV2KQ0KPiArew0KPiArCXN0cnVjdCBhZDQ2OTFfc3RhdGUgKnN0ID0gaWlv
X3ByaXYoaW5kaW9fZGV2KTsNCj4gKwlzdHJ1Y3QgYWQ0NjkxX29mZmxvYWRfc3RhdGUgKm9mZmxv
YWQgPSBzdC0+b2ZmbG9hZDsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJc3BpX29mZmxvYWRfdHJp
Z2dlcl9kaXNhYmxlKG9mZmxvYWQtPm9mZmxvYWQsIG9mZmxvYWQtPnRyaWdnZXIpOw0KPiArDQo+
ICsJcmV0ID0gYWQ0NjkxX3NhbXBsaW5nX2VuYWJsZShzdCwgZmFsc2UpOw0KPiArCWlmIChyZXQp
DQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gKwlzcGlfdW5vcHRpbWl6ZV9tZXNzYWdlKCZzdC0+
c2Nhbl9tc2cpOw0KDQoiSWYgYWQ0NjkxX3NhbXBsaW5nX2VuYWJsZSgpIGZhaWxzIGFuZCByZXR1
cm5zIGVhcmx5LCB3b24ndCB0aGlzIGJ5cGFzcw0Kc3BpX3Vub3B0aW1pemVfbWVzc2FnZSgpIGFu
ZCBwZXJtYW5lbnRseSBsZWFrIHRoZSBETUEgbWFwcGluZ3MgYW5kIG1lbW9yeQ0KYWxsb2NhdGVk
IGR1cmluZyBTUEkgbWVzc2FnZSBvcHRpbWl6YXRpb24/Ig0KDQpWYWxpZC4gc3BpX3Vub3B0aW1p
emVfbWVzc2FnZSgpIGlzIG5vdyBhbHdheXMgY2FsbGVkIGJlZm9yZSByZXR1cm5pbmcNCmZyb20g
cHJlZGlzYWJsZSwgcmVnYXJkbGVzcyBvZiBzYW1wbGluZ19lbmFibGUoKSByZXN1bHQuDQoNCj4g
Kw0KPiArCXJldHVybiBhZDQ2OTFfZXhpdF9jb252ZXJzaW9uX21vZGUoc3QpOw0KPiArfQ0KPiAr
DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGlpb19idWZmZXJfc2V0dXBfb3BzDQo+IGFkNDY5MV9j
bnZfYnVyc3Rfb2ZmbG9hZF9idWZmZXJfc2V0dXBfb3BzID0gew0KPiArCS5wb3N0ZW5hYmxlID0g
JmFkNDY5MV9jbnZfYnVyc3Rfb2ZmbG9hZF9idWZmZXJfcG9zdGVuYWJsZSwNCj4gKwkucHJlZGlz
YWJsZSA9ICZhZDQ2OTFfY252X2J1cnN0X29mZmxvYWRfYnVmZmVyX3ByZWRpc2FibGUsDQo+ICt9
Ow0KPiArDQo+ICBzdGF0aWMgc3NpemVfdCBzYW1wbGluZ19mcmVxdWVuY3lfc2hvdyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYsDQo+ICAJCQkJICAgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRy
LA0KPiAgCQkJCSAgICAgICBjaGFyICpidWYpDQo+IEBAIC04MTAsNiArMTA5Myw5IEBAIHN0YXRp
YyBzc2l6ZV90IHNhbXBsaW5nX2ZyZXF1ZW5jeV9zaG93KHN0cnVjdA0KPiBkZXZpY2UgKmRldiwN
Cj4gIAlzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2ID0gZGV2X3RvX2lpb19kZXYoZGV2KTsNCj4g
IAlzdHJ1Y3QgYWQ0NjkxX3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+IA0KPiAr
CWlmIChzdC0+bWFudWFsX21vZGUgJiYgc3QtPm9mZmxvYWQpDQo+ICsJCXJldHVybiBzeXNmc19l
bWl0KGJ1ZiwgIiVsbHVcbiIsIHN0LT5vZmZsb2FkLT50cmlnZ2VyX2h6KTsNCg0KVmFsaWQuIFVz
aW5nIFJFQURfT05DRSBpbiBzaG93IGFuZCBXUklURV9PTkNFIGluIHN0b3JlIGZvciB0cmlnZ2Vy
X2h6Ow0Kb24gMzItYml0IGFyY2hpdGVjdHVyZXMgYSBiYXJlIHU2NCByZWFkL3dyaXRlIGlzIG5v
dCBhdG9taWMuDQoNCj4gKw0KPiAgCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiVsdVxuIiwgTlNF
Q19QRVJfU0VDIC8gc3QtPmNudl9wZXJpb2RfbnMpOw0KPiAgfQ0KPiANCj4gQEAgLTgyOSw2ICsx
MTE1LDE5IEBAIHN0YXRpYyBzc2l6ZV90IHNhbXBsaW5nX2ZyZXF1ZW5jeV9zdG9yZShzdHJ1Y3QN
Cj4gZGV2aWNlICpkZXYsDQo+ICAJaWYgKElJT19ERVZfQUNRVUlSRV9GQUlMRUQoY2xhaW0pKQ0K
PiAgCQlyZXR1cm4gLUVCVVNZOw0KPiANCj4gKwlpZiAoc3QtPm1hbnVhbF9tb2RlICYmIHN0LT5v
ZmZsb2FkKSB7DQo+ICsJCXN0cnVjdCBzcGlfb2ZmbG9hZF90cmlnZ2VyX2NvbmZpZyBjb25maWcg
PSB7DQo+ICsJCQkudHlwZSA9IFNQSV9PRkZMT0FEX1RSSUdHRVJfUEVSSU9ESUMsDQo+ICsJCQku
cGVyaW9kaWMgPSB7IC5mcmVxdWVuY3lfaHogPSBmcmVxIH0sDQo+ICsJCX07DQoNCiJEb2VzIHRo
aXMgY29kZSBzYWZlbHkgaGFuZGxlIHplcm8gb3IgbmVnYXRpdmUgaW5wdXRzPw0Ka3N0cnRvaW50
IHBhcnNlcyBmcmVxIGFzIGEgc2lnbmVkIGludCwgYW5kIHRoZSBleGlzdGluZyB2YWxpZGF0aW9u
DQooaWYgKCFmcmVxKSByZXR1cm4gLUVJTlZBTCkgaXMgYnlwYXNzZWQgZm9yIHRoZSBvZmZsb2Fk
IHBhdGguDQpBIG5lZ2F0aXZlIHZhbHVlIHdvdWxkIHNpZ24tZXh0ZW5kIHRvIGEgbWFzc2l2ZSB1
NjQgdmFsdWUgd2hlbiBhc3NpZ25lZCB0bw0KZnJlcXVlbmN5X2h6LiINCg0KQWRkcmVzc2VkIHBl
ciBwcmV2aW91cyBwYXRjaC4NCg0KPiArDQo+ICsJCXJldCA9IHNwaV9vZmZsb2FkX3RyaWdnZXJf
dmFsaWRhdGUoc3QtPm9mZmxvYWQtPnRyaWdnZXIsDQo+ICZjb25maWcpOw0KDQouLi4NCg0KPiAt
CXJldCA9IGFkNDY5MV9zZXR1cF90cmlnZ2VyZWRfYnVmZmVyKGluZGlvX2Rldiwgc3QpOw0KPiAr
CWlmIChzcGlfb2ZmbG9hZCkgew0KPiArCQlpbmRpb19kZXYtPmNoYW5uZWxzID0gc3QtPmluZm8t
Pm9mZmxvYWRfaW5mby0+Y2hhbm5lbHM7DQo+ICsJCWluZGlvX2Rldi0+bnVtX2NoYW5uZWxzID0g
c3QtPmluZm8tPm9mZmxvYWRfaW5mby0NCj4gPm51bV9jaGFubmVsczsNCj4gKwkJcmV0ID0gYWQ0
NjkxX3NldHVwX29mZmxvYWQoaW5kaW9fZGV2LCBzdCwgc3BpX29mZmxvYWQpOw0KDQoiVGhlIG9m
ZmxvYWQgcGF0aCByZXVzZXMgdGhlIGV4aXN0aW5nIGNoYW5uZWxzIGFycmF5IHdoaWNoIGRlZmlu
ZXMNCnNjYW5fdHlwZS5lbmRpYW5uZXNzID0gSUlPX0JFLg0KU2luY2UgdGhlIFNQSSBvZmZsb2Fk
IERNQSBSWCBzdHJlYW0gZGVsaXZlcnMgZGF0YSBhcyBuYXRpdmUgMTYtYml0IHdvcmRzLA0Kd2hp
Y2ggYXJlIGxpdHRsZS1lbmRpYW4gb24gTEUgcGxhdGZvcm1zLCB3aWxsIHRoZSBJSU8gc3Vic3lz
dGVtIGluY29ycmVjdGx5DQpieXRlLXN3YXAgdGhlIG5hdGl2ZSBkYXRhIGJlZm9yZSBwYXNzaW5n
IGl0IHRvIHVzZXJzcGFjZT8iDQoNCkFncmVlZC4gQUQ0NjkxX0NIQU5ORUwgbm8gbG9uZ2VyIHNl
dHMgLmVuZGlhbm5lc3MsIG1hdGNoaW5nIHRoZQ0KYWQ0Njk1IGFwcHJvYWNoIGFuZCBkZWZhdWx0
aW5nIHRvIElJT19DUFUuDQoNCg==


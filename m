Return-Path: <linux-pwm+bounces-8586-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F4GHniN32l5VAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8586-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 15:07:04 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21597404AAA
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 15:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EC263053DFE
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 13:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0A638B122;
	Wed, 15 Apr 2026 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YxBfiL5w"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9BA38A73C;
	Wed, 15 Apr 2026 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258237; cv=fail; b=XGkCOoXngEeA2uPQQ+ic+6ytzJDe2okD00uIYiHxfi/mTfjCIMWyFU78JRVz6D7oyEpCC3U1nH+4mncc01k6wndAPfUc/i1jh5Fr+XmCtc4dlRV+BX7gCUtedIRLQ/I7D39ejK3jNpa/eOpLOEGbm8Q314FE5orwcBtkyUM7fHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258237; c=relaxed/simple;
	bh=4L3U9lMmcKco7SbcAfyT67XDbaJa9Kh6CXXXmII7siY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gX/nPVl4OuJoM7735XC/QaSueDvA2FGioq4MZ18Gbz7zpd9tOQtgqmqj3yzIXHVcmtlQlG0aMpYgAbcZbmn7jbuhlUKiUF2O3dOd83kV13USJAAE4rJ5wZFUrDTrvyus8pwilsmO4bqrWWD96/P0s6MuX+NyT/K8a1zA13NZmuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YxBfiL5w; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F7hXXC1444387;
	Wed, 15 Apr 2026 09:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4L3U9
	lMmcKco7SbcAfyT67XDbaJa9Kh6CXXXmII7siY=; b=YxBfiL5wh0D2b5ECx2N8z
	Bd6PEhciEiDupiyFrGRhxuFGuv0Edzr37BwuVAIwbzf7qCuVdzLiczL9qoJrsTcW
	iFHwyuxIB1OaMQYv39HbuFPjdiD/fer8IwbP3fNTwxn8wuSgBgOg2n8sSoPuJqZB
	iitXTswl19dC0umGSLZ+ihvlBVZf2DAoOnVlFJAT7d4oOQhAKaEI1uL4ehwj71PF
	Fff7tZ8fZehF4fT0hVZ2IWJFO99S0S5Q7+JFLxs1mdbpWh/WIWub4UHWsfW7txWB
	TUVWB4NEzMSO2oxFOXbPx1iGn2q6doKt2bYGn8Egl3Aq9ftAvf+JSuDE87jXJbgm
	g==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dh84rp3kh-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 09:03:19 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qX1CNzpPM0m7k4YPppyie2XhVHnVrWrex9dqH5OB4gB9JHLmov9qU/u+UrKLKSaGNvcleCiR5R2PpfkVZY4r/rML3I1p0raMadIcUsx+HLiRMzMsnVXplIkdoVl1nM1qSE16s6ehEiABzgBIeY9ukX4JYoTqe8oJY8elRFDOag2K2V2JRqsECnMOOJK3u6O2yaceBQ39NGQYXoWgrEWagmUWMhFSTj9VI92KS/kDOc8gvN40kLnBE419dR9zRuHu4mu7OlKlLdco+ThPQfWi6zpAyNOsbVjk1SFwTuzFpgNuB+GkW+CzEHlsI0qpkCFCtkmOy/DyNgfSxp2n802Ezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4L3U9lMmcKco7SbcAfyT67XDbaJa9Kh6CXXXmII7siY=;
 b=m9p+Uc3jBqJA+PYrS8+HXGTrbLOmAcTi1Jz23ii8jqAJ8JAcamzoT5kM9kDJxgolFyZ+aXMNqxBxNrivimvDMZEF2JhQBZf+Ec41a8mqZ9ypWKRmAiI2vjTtu2r/F5rRJgdZmwohkTFRapYwkhbut1njfxDqWr7WjRe8xbU8z5UQgZvlJxk9EJ6AGjS/UVAUfUnviJxFhtlkzJjcP46xzIsp9lnd9JGSjbbPasSPG5Op4DO8UDr2iLJeD4ZvOD+hChnMXGyabxPtpTjlVYBIwEiH0sb8DOq/nk++NAU1laLq90JP+nQwnJtjo+ObsoQ794SOk7SVsm3L6PV6hQTMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by PH8PR03MB989150.namprd03.prod.outlook.com (2603:10b6:510:3b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 13:03:17 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 13:03:17 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        David Lechner
	<dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "Sa, Nuno"
	<Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
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
Subject: RE: [PATCH v7 5/6] iio: adc: ad4691: add oversampling support
Thread-Topic: [PATCH v7 5/6] iio: adc: ad4691: add oversampling support
Thread-Index:
 AQHcyDWKLXLdMUxvy0qzqrU5i7lMELXYzdoAgALtoICAAuQOgIAAD3yAgAEiJICAAEYbkA==
Date: Wed, 15 Apr 2026 13:03:16 +0000
Message-ID:
 <LV9PR03MB8414CFF38DAD2BEB7AE3E704F7222@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
 <20260409-ad4692-multichannel-sar-adc-driver-v7-5-be375d4df2c5@analog.com>
 <742b1821-9103-414e-a860-c2e8d5406e35@baylibre.com>
 <20260412185821.739e477f@jic23-huawei>
 <LV9PR03MB8414E0A68C5676302909E220F7252@LV9PR03MB8414.namprd03.prod.outlook.com>
 <b352b76c-8047-4a1f-8b83-db8144466c36@baylibre.com> <ad9J9C5K7tyxuztU@nsa>
In-Reply-To: <ad9J9C5K7tyxuztU@nsa>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|PH8PR03MB989150:EE_
x-ms-office365-filtering-correlation-id: a15409c5-4c2b-489e-197a-08de9aef5c56
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021|18002099003|56012099003|22082099003|18096099003;
x-microsoft-antispam-message-info:
 F7f0txgT2aguTJAB+gCeE2EMfIAlGlH9fM1spxZig7GRVk85TS3Cysnx+ZhkmIkZvP0vcLIvdIz0d992DqYsJTmZzZOfF7RXU+xE+eF0Lcql8mRyVeZV+jeHjMBZKrRRVChOd2q9C8wnld+iw+lwEW70efRA3YyRF8m0HsS44tI1m/vTKn99yhh3Px3oJvuSTnBntF1b3/mAApNNUI3mR7zoiwpq8VAXYKm7+ke1w9e2Tey8L0qhiEgRNFBtNfC27yRQ6DDsVt8TyDUvIMt6AEe/WKqMOpZjpHQXjXKpTQ1Zs6rGiBj6ewoIT82bpm5VzvWQ47vAQTZAnEL71GWTl1o5XySW5DdGMjSxhAffUClNI4YZIA5ij9XbiKrEU+HExDXfxhN7WrYszDGQZvdplq8WOwV/uzKudLhyxR7GQ1eEi3Q0FMbSCFMJg++Y2iMXcAH1vDOtakXPIcTJPfCDznewDLl/rfr56fyPrZJsMhDS/VnYD7NVULPdm9z2YAC+dcnWRKEp/IKLcvWKdA9uQSG4ZU5gqF7QoAQ7w3go1hHJ74ioC219Ia88GYHYYPFbDZhTqn6CzjaI9JR8U9RzpDGE7mUsGdfgKUrOMQlArYnakUnHxFmHHx1L242kpFoK0eA8WTbg2ci7g0P4amKIbutE2iRjiLpN3DIQepVW8T2neSjEAbt5gtn9SuLBBQLqOg7CtGmC4aMVpG8IHCynqVy2qvJY0lHlG70fB4vh9IY7N+fQ37r2NAF53cHBpXWhcnFKJTrRN/81dCIeI+iOfauLfBbSFsOH6VBDczHUSSM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003)(18096099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?emlYUVp6RnNXQUtlaXlZVkUzaUlpdjZzWkhZcjd3N2I1MHMyS1RUQWFsNmZE?=
 =?utf-8?B?cy81WWxBSXVwYjByRHREV2RCZ21iSk9xTXpsbm9iOHBRZE0vWmkvWk5lVmpG?=
 =?utf-8?B?alBOa1BmNGpXUisxeFZiTHh5U2s1QmhHK1ZBeVVVekkwQURsZ2tHNnlSd3kr?=
 =?utf-8?B?b2RBZkNoWGQ1RzZyd0pvY21haTRDT3Bzd3l5L2JHRnJDeXk2bDVBYllac1M4?=
 =?utf-8?B?MkJoZE44TDg1bDlJc1BPdjNYck5PZGdpWmI4azZkL3pWQ0UrdGQybk9yQkcv?=
 =?utf-8?B?ZTdXNjhuRjdKTFo0aU1qM3ZaTGFmWnhDWDV5Um0zUjRZbFVIZE1yZjdkVXBH?=
 =?utf-8?B?eE1jUkF3ZndXZG80R0dJYzZUQlAvbER5dTVlcHFsYTUxR0VGZGVaZ2NzU0Yz?=
 =?utf-8?B?UTJWRVpKcG1MQWxpLzRucjVDUHZTYVZYVW4zUE1uMng2QUpKSWRzYXcvQ0xi?=
 =?utf-8?B?MWFSTkUxOXR3SVF4cDM2U3hZdnpsamU3RklvSnlucHV6UDJXVFowaGdBVlZD?=
 =?utf-8?B?eTZmVGpTSElUWFRtZnZueURmUmNldnBKcVhydDZSUTVsUVFDWkxSVW9HTDFN?=
 =?utf-8?B?dTArcHZLeER1VEhoNHVrVU5LZm9ZNEJyRVpDcGprSS9MaXh3OWMyMTZkK1B1?=
 =?utf-8?B?bERTSkZjZEtpdEJMVzIrY2tvK1VRbXdxcDYxa3V6WU1Qc25ZcmFxVHE1TU1u?=
 =?utf-8?B?dGg2TDQ4cHN4dytxeER1eUhYV3ArNytaV2N6RFgwVFFKWmtOcGE2N0JNcnN5?=
 =?utf-8?B?QkFkTC9uOTlsOWdLU2htaHBOTCtQdGluOUVHSlRZYkQ5bzRZVkI2bkFUZTg2?=
 =?utf-8?B?OTNWbW8zdmJWKy9QYVIwQjYrNGdKSGwxTms1bXQ4TEJ2c2NtdjVKNmZrZjkv?=
 =?utf-8?B?NUFvcTlXMEJWUWlURVV0bFVuVkUxOEc1MWVwRmVJSEJEcGpHM1hwRW5Bb3Za?=
 =?utf-8?B?ZlFFbjM4Q3ZaSG1YSkRUdXA1a0tpUGlNRGdPN1Fwem42RENZK2VrMGcvdWV1?=
 =?utf-8?B?ZWZpRDIwUzA0aEVpUmlZT0tzazRoMEoxb3J3c1BXUm0ycnR6NlJLK1B4K01E?=
 =?utf-8?B?R1poY3JvUGplcTlTR0NhVDU3WlV6Mkg4a3RZRENKZHovbmJXNGFESjZUNHh5?=
 =?utf-8?B?N3RmMGVDQ2NvN1JyRzFLMDcwMDFOa3MyUEJmbk12elNRZ3ZJY0ZVMjc5Skly?=
 =?utf-8?B?YzlQQUtWa2dUS1V3Z3N4enQ4OHhkZWh4SWFjbmdCbitqUk1kQ0YvOGJHNEQr?=
 =?utf-8?B?RzMrUE5GUUprZCtPWnlpY0VMV1BEMmVYZVljWHdtaHdyb1FBRmorOEw2YVI3?=
 =?utf-8?B?dHlDZ2tqYkYvVWN1eVB1NjdjRWFPeVRyU3VZeW5CL1FndVlMTEtOaXMrZTVW?=
 =?utf-8?B?eUFyMk1PcndhUS8ycEljdHlyNDYvT0VEdmZLZit0aEJNdFljRWlTZC9BVEx4?=
 =?utf-8?B?cWpBTHRlUTlYSk1YSFdmT04xcG9FdGpBYXB1dk53TmxzU3pyclVvSERvRzFl?=
 =?utf-8?B?T3o5d2Z6QzRTZm54bG9RWXlkdjVLaGpzZVRkYXc1L0ZYdkdIbndXRGUrUmx2?=
 =?utf-8?B?cmpDVExwNFlFQnFZMUU5bG9mWDFXTi9nOEE1cXMvcVN3TUJzSGlBNnNPYTB1?=
 =?utf-8?B?aFVTYVFDa2U0dytlVUpJbG15ZVkyMUNBRzVxaXpIZkhwdEYrYVZKVGE4SGFV?=
 =?utf-8?B?c3IwMXE4UzVSb0E5ZWpPdW5Ocmg1MXkvOFV3T3ptamNHZFNkajZBMXJEU3NT?=
 =?utf-8?B?THREUW1hNW9WNUxrWDFRU09OcWZRU3RZeTZ4MlRGTjErRDh4bUd5UnYrODJF?=
 =?utf-8?B?WWdGZzRiMXZGRkZVOUlVd2UwN3pRVEtyaDcwUFl0WUw4aCtaaHJWTHZyNU9z?=
 =?utf-8?B?eDNzaXlFclNxYk9ER3czQTZId2V1VTlkNEpLazVMcmRacmVVRy8xS2l6Q0FD?=
 =?utf-8?B?dWNaYWNoR2ZTbUsxTXVBdGF2YWx2YmpoZFpxNlZ3dE1GSk5PTWFPVnBXTU1o?=
 =?utf-8?B?K2hGcUVEbThLQTc3VHRtS3pjdGdQbmpXSDNKMGxjS1NOWjc5blNPMVdJL24x?=
 =?utf-8?B?L3Znb1V0Zy9rZSs3enpaMG1jVy9xK2hpZytwU2RNVEl6NUsxR0J3RWR2SmhS?=
 =?utf-8?B?VHhrZ2Jjd2NiSkJmT1kvOEZOQ0ZhMDlDeXQwcFdNekFGVWRrNFI2dndQMm8w?=
 =?utf-8?B?a1I4MldXYm1WcERJWC93VW91Tmk1cWg3YVlEM0dLaHc5TlROR3IwSVVGeEdj?=
 =?utf-8?B?VEF4UnlGNy9jREZ3WGJhbUlXY0N6aDJUK3ZMNGNLU0N2azduUExxc0NUU0Vy?=
 =?utf-8?B?YVBrNC92Qlc2Ulc2T0VxcmtzOXBRRk1YaVZROTBSQUp4QURuNDdQQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ITo3EnRd0SugDzEYDe/a9bpRJyWTHDBMnp21FEJycPCg1pIJ8eW6iwzKtRiSKuAO+Z3lgsRS2Cxc4Tf45uWi8Oq7nrY3Rg5UowvSaPQNhFFtPeD7rPMzr+spI2U7PJVBu7OkmGgR+Re7w6FOdUHFw2M1t+zOGghQlErt3VH7YYoicYsZGQctodLo6EzRiUcdyOYPOE/907nUNM2YU/eABoEVVX0XTJLP1uSI2eaAta1zjBO8MPaCQA8of6naTn/2qVOZ+WhqMJm7TlXC1SDJCmohS0GQWg4cEdT2rOi0x3uLVhiXx0MPqEepTV9epZa1BwfCO/HwflxL5qyM8bK0lg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a15409c5-4c2b-489e-197a-08de9aef5c56
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 13:03:17.0052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kMVqRwL9n8rgSFOeiQPHtEWUNIufEVGdGTr7v6nrxV2+DDybdYm+h5V9+4Hd5L8rEfoWYBGUccwfJCvXZbE9DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB989150
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEyMSBTYWx0ZWRfXwxTdSLuEHp+a
 FNvqpdF5MeW6KdujwBeTJL4JDSWD/zC9E2bhNgJWLcppObFHqTW0FDxHfYwABawNoeAF8gtZvwq
 oKlzDEk8VXADeNsDXfvl6d9yUa5l1YcX3Aov4IGImuy+irnCYhOQgzaSIV+SIncoeGlkdpCaevF
 lDGInTmR5XTxwzgSZ1Kg2BApyAKwTpzi8WtivGwt7Zx2WVg7bUJeBkRbJrCVtXF9lCunM4je6Bu
 66IGfY/uO0vdZiP/nNrU7RlKupCmLppUYA2BxlWe32uk6xlfabMT9CS2/DU943OMfOFf7ug8ggE
 lJv9bzPDGxdoHGQVkXpv6ir0pbyoVK1vjmLNgKEKEUmvqxA8RWE1gfkU8ydo/27lLqv7zEnY2a9
 KHfh6ZK2V8mc65lF3A/i6WI8i/PNjP0t9TN+CuDBA6pvoFKk3HoVSf8zVcLWsTwCwEar7Vl2Q3y
 Yhb9ZuD+olzrzeOXJ/A==
X-Proofpoint-GUID: B3aoRSBOHr3g5Oilt-8QAYZGV01VMnUc
X-Proofpoint-ORIG-GUID: B3aoRSBOHr3g5Oilt-8QAYZGV01VMnUc
X-Authority-Analysis: v=2.4 cv=R/kz39RX c=1 sm=1 tr=0 ts=69df8c97 cx=c_pps
 a=xOYz1KraVtwoi73AohHYLg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=pGLkceISAAAA:8 a=leaUJgLpUCMiP1JXjMUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150121
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8586-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,baylibre.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,metafoo.de,analog.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
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
X-Rspamd-Queue-Id: 21597404AAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOdW5vIFPDoSA8bm9uYW1lLm51
bm9AZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDE1LCAyMDI2IDExOjIxIEFN
DQoNCi4uLg0KDQo+ID4gPg0KPiA+ID4gTW9yZSB0aGFuIHRoaXMsIGlmIHRoZSBPU1IgaXMgMzIg
dGhlIG1heGltdW0gZWZmZWN0aXZlIHJhdGUgd291bGQgYmUNCj4gMzEyNTAsIHNvIDI1a0h6DQo+
ID4gPiB3b3VsZCBtYWtlIGl0IHRoZSBjbG9zZXMgYXZhaWxhYmxlIG9uZS4gSWYgdGhlIHVzZXIg
d291bGQgc2VsZWN0IDFNSHogZnJvbQ0KPiB0aGUgYXZhaWxhYmxlDQo+ID4gPiBsaXN0IGl0IHdv
dWxkIGJlIHdlaXJkIEkgd291bGQgc2F5LiBTbyBwZXJoYXBzIGEgc29sdXRpb24gZm9yIHRoaXMg
aXMgdG8gZGlzcGxheQ0KPiB0aGUgYXZhaWwgbGlzdA0KPiA+ID4gZGVwZW5kaW5nIG9uIHRoZSBz
ZXQgT1NSIHZhbHVlLg0KPiA+DQo+ID4gWWVzLCB0aGUgYXZhaWxhYmxlIGxpc3Qgc2hvdWxkIHJl
ZmxlY3QgdGhlIGN1cnJlbnQgc3RhdGUgb2YgYW55IG90aGVyIGF0dHJpYnV0ZXMNCj4gPiB0aGF0
IGFmZmVjdCBpdC4NCj4gDQo+IElNTywgdGhlIGFib3ZlIG1ha2VzIHRvdGFsIHNlbnNlIHRvIG1l
Lg0KPiANCj4gLSBOdW5vIFPDoQ0KPiANCg0KSGkgZXZlcnlvbmUgYW5kIHRoYW5rIHlvdSBzbyBt
dWNoIGZvciB5b3VyIGZlZWRiYWNrIQ0KDQpBZnRlciB0aGlua2luZyB0aGlzIHRocm91Z2ggY2Fy
ZWZ1bGx5IGFuZCB0ZXN0aW5nIG9uIGhhcmR3YXJlIChhZDQ2OTIpLCBoZXJlIGlzDQp0aGUgZGVz
aWduIEkgaGF2ZSBpbiBtaW5kOg0KDQppbl92b2x0YWdlTl9zYW1wbGluZ19mcmVxdWVuY3kgPSBl
ZmZlY3RpdmUgcmF0ZSA9IGBvc2NfZnJlcSAvIG9zcltOXWA6DQoNClRoZSBjaGlwIGhhcyBhIHNp
bmdsZSBpbnRlcm5hbCBvc2NpbGxhdG9yIHNocmVkIGJ5IGFsbCBjaGFubmVsczsgZWFjaCBjaGFu
bmVsDQppbmRlcGVuZGVudGx5IGFjY3VtdWxhdGluZyBvc2NbTl0gb3NjaWxsYXRvciBjeWNsZXMg
YmVmb3JlIHByb2R1Y2luZyBhIHJlc3VsdC4NCg0KV3JpdGluZyBpbl92b2x0YWdlTl9zYW1wbGlu
Z19mcmVxdWVuY3kgPSBmcmVxOg0KDQpUaGUgZHJpdmVyIGNvbXB1dGVzIHRoZSBuZWVkZWRfb3Nj
ID0gZnJlcSAqIG9zcltOXSBhbmQgc25hcHMgZG93biB0byB0aGUgbGFyZ2VzdA0KYXZhaWxhYmxl
IG9zY2lsbGF0b3IgdGFibGUgZW50cnkgc2F0aXNmeWluZyBib3RoIGBvc2MgPD0gbmVlZGVkX29z
Y2AgYW5kIGFuIGV4YWN0DQpkaXZpc2lvbiB0byBvc3IuIFRoZSBkaXZpc2liaWxpdHkgY29uc3Ry
YWludCBlbnN1cmVzIHRoZSByZWFkLWJhY2sgaXMgYWx3YXlzIGFuIGV4YWN0DQppbnRlZ2VyLg0K
VGhlIHJlc3VsdCBpcyBzdG9yZWQgaW4gYSBzaW5nbGUgc2hhcmVkIGB0YXJnZXRfb3NjX2ZyZXFf
SHpgIC0gd3JpdGluZyB0aGUgYXR0cmlidXRlDQpmb3IgYW55IGNoYW5uZWwgY2hhbmdlcyB0aGUg
c2hhcmVkIG9zY2lsbGF0b3IgYW5kIHRoZXJlZm9yZSB0aGUgcmVhZC1iYWNrIG9mIGFsbA0Kb3Ro
ZXIgY2hhbm5lbHMuDQoNCmluX3ZvbHRhZ2VOX3NhbXBsaW5nX2ZyZXF1ZW5jeV9hdmFpbGFibGU6
DQoNCkNvbXB1dGVkIGR5bmFtaWNhbGx5IGZyb20gdGhlIGNoYW5uZWwncyBjdXJyZW50IE9TUi4g
VGhlIGxpc3QgbmF0dXJhbGx5IGJlY29tZXMNCnNwYXJzZXIgYXMgT1NSIGluY3JlYXNlcywgY2Fw
cGluZyBhdCBgbWF4X3JhdGUgLyBvc3JbTl1gIHdoaWNoIGlzIGV4YWN0bHkgdGhlIGNoaXAncw0K
YmVoYXZpb3VyLCBhbmQgdGhlcmVmb3JlIG1vcmUgaW50dWl0aXZlIGZvciB0aGUgdXNlci4NCg0K
T1NDX0ZSRVFfUkVHIHdyaXRlIHRpbWluZzoNCg0KYHRhcmdldF9vc2NfZnJlcV9IemAgaXMgd3Jp
dHRlbiB0byBoYXJkd2FyZSBhdCB0d28gcG9pbnRzOg0KLSBTaW5nbGUtc2hvdCByZWFkOiBpbW1l
ZGlhdGVseSBiZWZvcmUgc3RhcnRpbmcgYWNjdW11bGF0aW9uLg0KLSBDTlYgYnVzcnQgYnVmZmVy
IGVuYWJsZTogaW5zaWRlIGVudGVyX2NvbnZlcnNpb25fbW9kZSwgYWZ0ZXIgdGhlIG1hbnVhbCBt
b2RlDQplYXJseSByZXR1cm4gKG1hbnVhbCBtb2RlIHVzZXMgU1BJIENTIHRvZ2dsaW5nLCBub3Qg
dGhlIGludGVybmFsIG9zY2lsbGF0b3IsIHNvIHRoZQ0Kd3JpdGUgaXMgc2tpcHBlZCB0aGVyZSku
DQoNClRoaXMga2VlcHMgdGhlIGRlZmZlcmVkLXdyaXRlIGJlbmVmaXQgLSBib3RoIHNhbXBsaW5n
X2ZyZXF1ZW5jeSBhbmQgb3NyIGNhbiBiZQ0Kc2V0IGluIGFueSBvcmRlciBiZWZvcmUgZW5hYmxp
bmcgdGhlIGJ1ZmZlci9zaW5nbGUtc2hvdCByZWFkaW5nLg0KDQpCdWZmZXIgTW9kZToNCg0KQWZ0
ZXIgZGVzaXJlZCByYXRlcy9vc3IgYXJlIHNldCBieSB0aGUgdXNlciBmb3IgZWFjaCBjaGFubmVs
LCByZWFkaW5nIGJhY2sgdGhlIHNhbXBsaW5nDQpmcmVxdWVuY3kgb2YgZWFjaCBjaGFubmVsIGdp
dmVzIGhpbSB0aGUgdHJ1ZSBlZmZlY3RpdmUgcmF0ZSBmb3IgZWFjaC4gVGhlcmVmb3JlDQpoZSBj
YW4gdXNlIHRoYXQgaW5mb3JtYXRpb24gaW4gb3JkZXIgdG8gc2V0IHRoZSBidWZmZXIgc2FtcGxp
bmcgZnJlcXVlbmN5IGFjY29yZGluZ2x5DQphbmQgaGVscGluZyBoaW0gdXNlIHRoZSBjaGlwIHdp
dGggY29ycmVjdCBzeW5jaHJvbml6YXRpb24gbW9yZSBpbnR1aXRpdmVseS4NCg0KSSBoYXZlIGFs
c28gcGVyZm9ybWVkIHRoZSBuZXh0IHRlc3QgdXNpbmcgdGhlIGhhcmR3YXJlIGFuZCBnb3QgY29y
cmVjdCByZXN1bHRzOg0KLSB0ZXN0IGNhc2UgKGFkNDY5MiwgMU1IeiBtYXhpbXVtIGludGVybmFs
IG9zY2lsbGF0b3IgcmF0ZSk6DQoNCjEuIFNldCBjaGFubmVsIDAgT1NSPTMyLiBBdmFpbGFibGUg
bGlzdDogezMxMjUwLCAxNTYyNSwgMTI1MDAsIDYyNTAsIDMxMjV9Lg0KICAgIFdyaXRlIHNhbXBs
aW5nX2ZyZXF1ZW5jeT0xMDAwMCAobm90IGluIHRoZSBsaXN0KSAtPiBzbmFwcyB0byA2MjUwIChv
c2M9MjAwMDAwSHopLg0KICAgIENvcnJlY3QgcmVhZGJhY2sgPSA2MjUwLg0KMi4gU2V0IGNoYW5u
ZWwgMSBPU1I9NC4gUmVhZCBjaGFubmVsIDEgc2FtcGxpbmcgZnJlcXVlbmN5IC0+IDUwMDAwICg9
MjAwMDAwLzQpLg0KICAgIFNoYXJlZCBvc2NpbGxhdG9yIGNvcnJlY3RseSByZWZsZWN0ZWQgYWNy
b3NzIGNoYW5uZWxzLg0KMy4gQ2hhbmdlIGNoYW5uZWwgMCBPU1IgZnJvbSAzMiB0byA4LiBEcml2
ZXIgcmVjb21wdXRlcyBhcyBmb2xsb3dzIDogZWZmZWN0aXZlIHN0YXlzDQogICAgNjI1MCBhcyBi
ZWZvcmUgYW5kIG5lZWRlZF9vc2MgYmVjb21lcyA1MDAwMCwgZXhhY3QgdGFibGUgaGl0LiBSZWFk
YmFjayBjaGFubmVsIDA6DQogICAgNjI1MCAocmF0ZSBwcmVzZXJ2ZWQpLiBSZWFkYmFjayBjaGFu
bmVsIDEgKE9TUj00KTogMTI1MDAuIChvc2NpbGxhdG9yIGNoYW5nZSB2aXNpYmxlKS4NCiAgICBU
aGUgc2FtcGxpbmcgZm9yIGNoYW5uZWwgMCBjYW4gYmUgb2YgY291cnNlIHNldCB0byBhbm90aGVy
IGF2YWlsYWJsZSB2YWx1ZSBhcyB3ZWxsIGFuZA0KICAgIE1ha2UgbWF0Y2ggd2l0aCB0aGUgaW5p
dGlhbCByZXF1ZXN0ZWQgNTBrIG9mIGNoYW5uZWwgMS4gKGluIHRoaXMgY2FzZSwgc2V0IGNoYW5u
ZWwgMCB0bw0KICAgIDI1aykuDQo0LiAtRUlOVkFMIHJlamVjdGlvbiBpcyBhdG9taWM6IHdpdGgg
T1NSPTEgYW5kIFNGPTEyNTAgYXQgc3RhcnQgZm9yIGxldHMgc2F5IGNoYW5uZWwgMCwgd3JpdGlu
Zw0KICAgIE9TUj0zMiBpcyByZWplY3RlZCBzaW5jZSB0aGUgbmVlZGVkX29zYz00MDAwMCwgd2hp
Y2ggaXMgbm90IGEgdGFibGUgZW50cnkgYW5kIGFsc28gaGFzIG5vDQogICAgdGFibGUgZW50cnkg
PD0gNDAwMDAgdGhhdCBpcyBkaXZpc2libGUgYnkgMzIpLiBCb3RoIE9TUiBhbmQgU0YgcmVtYWlu
IHVuY2hhbmdlZC4gUmFpc2luZyBTRg0KICAgIHRvIDUwMDAwMCBmaXJzdCB0aGVuIHdyaXRpbmcg
T1NSPTMyIHN1Y2NlZWRzIC0gb3NjIHNuYXBzIHRvIDEwMDAwMDAsIHJlYWRiYWNrIFNGPTMxMjUw
Lg0KICAgIA0KICAgIEluICg0KSBjYXNlIHdlIGNvdWxkIHN0aWxsIGxldCB0aGUgdXNlciBoYXZl
IGl0cyBzYW1wbGluZyBmcmVxdWVuY3kgYXMgaXMgKDEyNTAvMzI9MzkuMDYyNSksDQogICAgdGhv
dWdoIGl0IHdvbid0IHJlc3VsdCBpbiBhIHByZWNpc2UgdHJ1ZSBpbnRlZ2VyIHZhbHVlLCBidXQg
YSByb3VuZGVkICgzOSkgb25lLCBhbmQgd2hlbg0KICAgIG90aGVyIGNoYW5uZWwgd291bGQgaGF2
ZSBPU1IvcmF0ZSBjaGFuZ2VkIGl0IHdvdWxkIGltcGx5IGEgbWVzc3kgY2hhbmdlIGluIHRoZSBw
cmV2aW91cw0KICAgIGNoYW5uZWwncyBTRiBhbmQgcmVxdWlyaW5nIGEgbm9uLWV4aXN0ZW50L21h
dGNoaW5nIGludGVybmFsIG9zYyB2YWx1ZSAobW9zdCBvZiB0aGUgdGltZXMNCiAgICBhIGZsb2F0
IG9uZSksIGFuZCB0cnVlIFNGIHdvdWxkIGJlIGxvc3QuDQoNCkRvIHlvdSBndXlzIHRoaW5rIHRo
aXMgYXBwcm9hY2ggc3VpdHMgdGhlIGJlc3Q/DQoNClRoYW5rcywNClJhZHUNCg0KICAgID4NCj4g
PiA+DQo+ID4gPiBMaW5raW5nIHRoZSB0d28gdG9nZXRoZXIgaXMgcGVyaGFwcyB3cm9uZyB0byBi
ZWdpbiB3aXRoIGZyb20gbXkgZW5kLA0KPiBzaW5jZSBpbiB0aGlzDQo+ID4gPiBkcml2ZXIncyBj
YXNlLCB0aGUgcGVyLWNoYW5uZWwgc2FtcGxpbmcgZnJlcXVlbmN5IGlzIGNvbnRyb2xsZWQgYnkg
dGhlDQo+IGludGVybmFsIG9zY2lsbGF0b3INCj4gPiA+IHdoaWNoIGhhcyBzdGF0aWMgYXZhaWxh
YmxlIHZhbHVlcy4gU28gcGVyaGFwcyBzYW1wbGluZyBmcmVxdWVuY3kgc2hvdWxkIGJlDQo+IHNl
cGFyYXRlLCBhbmQNCj4gPiA+IE9TUiBzZXBhcmF0ZSBhcyB3ZWxsLCB3aGljaCB3b3VsZCBtYWtl
IGV2ZXJ5dGhpbmcgY2xlYW5lci4NCj4gPiA+DQo+ID4gPiBJbmRlZWQsIHRoZSBlZmZlY3RpdmUg
cmF0ZSBpcyBjaGFuZ2VkIGJ5IE9TUiwgYnV0IHBlcmhhcHMgdGhhdCBpcyBzb21ldGhpbmcNCj4g
dGhlIHVzZXINCj4gPiA+IHNob3VsZCBiZSBhd2FyZSBvZiwgc2luY2UgdGhlIHNhbXBsaW5nIGZy
ZXF1ZW5jeSBpcyB0aGUgcmF0ZSBhdCB3aGljaCB0aGUNCj4gY2hhbm5lbCBzYW1wbGVzDQo+ID4g
PiAoMSBzYW1wbGUgcGVyIHBlcmlvZCkgYW5kIE9TUiBpcyBob3cgbWFueSB0aW1lcyB0aGUgY2hh
bm5lbCBzYW1wbGVzDQo+IHVwb24gYSBmaW5hbCBzYW1wbGUNCj4gPiA+IGlzIHRvIGJlIHJlYWQu
IFRoZSB1c2VyIGFscmVhZHkgaGFzIHRvIHRha2UgdGhpcyBpbnRvIGFjY291bnQgd2hlbiBzZXR0
aW5nDQo+IHRoZSBidWZmZXINCj4gPiA+IHNhbXBsaW5nIGZyZXF1ZW5jeSwgc28gaXQgd291bGQg
bWFrZSBzZW5zZSB0byB0YWtlIHRoaXMgaW50byBhY2NvdW50IGhlcmUNCj4gdG9vLg0KPiA+DQo+
ID4gV2UgY2FuJ3QgY2hhbmdlIHRoZSBkZWZpbml0aW9uIG9mIHRoZSBJSU8gQUJJIGp1c3QgdG8g
bWFrZSBvbmUgZHJpdmVyIHNpbXBsZXINCj4gPiB0byBpbXBsZW1lbnQuIFRoZSBPU1IgYW5kIHNh
bXBsZSByYXRlIGNhbid0IGJlIGNvbXBsZXRlbHkgaW5kZXBlbmRlbnQuDQo+ID4NCj4gPiBJZiB5
b3Ugd2FudCB0byBsZWF2ZSBpdCB0aGUgd2F5IGl0IGlzIGN1cnJlbnRseSBpbXBsZW1lbnRlZCB0
aG91Z2gsIHRoYXQgaXMNCj4gZmluZS4NCj4gPg0KPiA+ID4NCj4gPiA+IFBsZWFzZSBsZXQgbWUg
a25vdyB5b3UgdGhvdWdodHMgb24gdGhpcywNCj4gPiA+IFJhZHUNCj4gPg0K


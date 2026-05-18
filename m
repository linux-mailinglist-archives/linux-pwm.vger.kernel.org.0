Return-Path: <linux-pwm+bounces-8966-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKzrCXMqC2pAEAUAu9opvQ
	(envelope-from <linux-pwm+bounces-8966-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:04:19 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6AB56F818
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 864A63043883
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 15:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E880A30E829;
	Mon, 18 May 2026 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="tXAcasjN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE2A33A6F1;
	Mon, 18 May 2026 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116420; cv=fail; b=AfkrhlPSzB4yRuD9jhRTf0kuX7Q9nlieHSjFkwVM1xcMqaEQxqC6QzXOFcjsRv+ZQOoFCq2yHpHGy+oSsBDYmOwewAUqxLjfiKDIKBaBQt4j8QTQFOap6MkIl7nX/pdeAGOwDNJvsIAMtGcVYzVkcboSaCYXkKVI6BwUX0qish4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116420; c=relaxed/simple;
	bh=oEAtu83xU1lgCvfnAhSyByfdRoYa+MJ00Ildaex3I5c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F3AklE0kFdqXp0r7t//WO8NB4S6VNYRo/15sEbw1hcuLRk8+kcU29N5CfLsKUi6bzG4rc0XsEUhFBKf5aoEvFyg/V1UBZzlzRLp+CDMZ3fJO+EdgVetut6psDmhdIHuQyP90iNLerm3ykS2agvzvNSn4fW1cVlST3CTh2yDiijE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=tXAcasjN; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IBCl3S2482903;
	Mon, 18 May 2026 10:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=oEAtu
	83xU1lgCvfnAhSyByfdRoYa+MJ00Ildaex3I5c=; b=tXAcasjNlUGYNI++GI2Uz
	0lUezJ0JNXL1fkJJbXJQOjlH/Kq1Z3STaCi0CphT9xHaXgCsn5ObxAil9DYlwuKy
	GqTfnN/sTmw3VwjcvgZql5lCJKd+l7DERw1AZNOJu2C4SbSET+UkuEGwNpHkPvOd
	nYChoFhZWCjqoz4DbHXrHYLSbxOlJKBC7ztXVctUKhaTQf4LTHlwbZ5b7dgSk2rW
	ywbvnLHv95c2uPezVfka3A17H+bceoWH7I+H9NaiULmAvi1Gqb9FB/L9f+xpYe+3
	exTYM6vdXMHwlwbOdc+Ae50qgKDQWis8njZwUPU5Ls21zi7VTquknPiiVW5PvPH6
	w==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e6ng0xdmf-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 10:59:55 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylx9eZKBjTp3O8OsubL/w1LFs9ZeG8nisuhjhwPrNpVF5LP/Bf/fe2mx4WsoabXwBpRbv9wAemmQmH3pQqoFi+fPjMhOH3KZTM9DYQoVld1LrMYA5TF54h3H/VcUpyFwHcX08w2Z+7G6I15VyARXhkiuj0SzrqPcSYD7qsKd8HV2b9mgaVTryqw9GKXurRtf81G7ohUqZHCWGvnBIAjfRrOu2+PUdspoUuW62soEeCFUNJfOtlzPhijcqid70BPg66MAcUUJ+CEGJb0BRkZuSLaYVWOp5F1lM58co74Vf0G1oXLIXuGp71fWRHOdw/SAaXadB4yxoOAJS70qQmGavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEAtu83xU1lgCvfnAhSyByfdRoYa+MJ00Ildaex3I5c=;
 b=ENkZnZ/1F11Er1mBvDHONVxp4vme8P9mte1S54NasrxuivIga2KmYKYlrMsKNV/y+BE08iqjx5cnzwU81VlicTMS6jKU9FlHjixwVfevs214b9lPlkcEP7TS+x8YWe2nSXkbMUjDygmT/XMhDRtvNjC+IOfdM6om4AmPG5jcbfskFfAYB/Roqf49FHfGLK0tixounVGrFxxwq3t6OWEMwgb43/7CdZqKjV2DvgvL+3A2EQ9yVN1RP/mcdpZCwAlP5HtjrNa1Ip0vGUULfhE3NF3hwgZEYv37vU66QSvmlMmYfOJVkD0kfgODDJvcnWk8i6V6AzfpAWA0wAOlW0ArnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by DS4PR03MB8446.namprd03.prod.outlook.com (2603:10b6:8:322::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 14:59:51 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.21.0025.023; Mon, 18 May 2026
 14:59:50 +0000
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
Subject: RE: [PATCH v11 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Topic: [PATCH v11 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Index: AQHc5G8oCth+klOl+E2cQcQun6UuM7YQ5SQAgAL81cA=
Date: Mon, 18 May 2026 14:59:50 +0000
Message-ID:
 <LV9PR03MB841445D5BD1087FB3204EBD9F7032@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
 <20260515-ad4692-multichannel-sar-adc-driver-v11-2-eab27d852ac2@analog.com>
 <0696b662-f478-4d1a-95e0-0338bbdb719e@baylibre.com>
In-Reply-To: <0696b662-f478-4d1a-95e0-0338bbdb719e@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|DS4PR03MB8446:EE_
x-ms-office365-filtering-correlation-id: 061a31d9-7bca-4a43-1ed2-08deb4ee1c59
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|22082099003|56012099003|38070700021|921020|4143699003|11063799003;
x-microsoft-antispam-message-info:
 ma9p/cz9taBKw1nj62fZjA3UpX0wfH+KJE+TNDB22sLEpZdBys5uQIHCYZMvG2h8d5iUMMc5GpCdoj62pLR8+/ihslOf9WR2xl/nLZlsl1IhaBbWuil4q9pNstay3YePuY+I+DWeXRORQj5Ihn1vXYKGOs4Y8iSxJ+AFsLyldbLfO0bFjRlNABvv1s2aYQvDVxPMt8zYDsdzP69lb5o47oDgKpxHp3qU+CKhJfjzujcR85OMQI53lMLZ+HeOq3PiRqTbsNTETM2ZJ/zPvXVTa8XWMdl4ydeQ4uPFRA9EWQiMU/5Ik27dAYb3ZLfNOKch2bP6Pl8d1wRbmDlmqr+Vw+Txo5sgM3PYhTzD2EWjsDmJSoGVZCJSJpny7bqxrN/JiRLyIAN1d/2Z2GR7qyla8sihSrv/NVK9+WxeBoQAaVJO6dVTUrl6KxqqkOaG4151Xa5D7bGPurWmjEcs1J56UPMwZJwEZHJJzZPKZxZ9aBZP/mvLC4m73Q7CwDtRbwfQZeQ7rR3yYSyoFLQCr5AZ0cFEM3BE1kP4Qc7vy/xQBjygXwpUqiLNVbkoDu0z+F9IBL97Dhc7uAn6tQ5psbUmqCJmHnBto+L4TSQSyP2tiJyn0G+pNQXyY0LOtbJ4qUTMpud7VPNEi4z49ERMu9Ksj16ZLc0DH9kBCdVs2KATWd9TWIPY63KVW+eMnt9eAwXMB5EA44ncsTcXJbdqff3jGH8xGJN1634BEKDcridE6/iv22jGQjvlLCo/M3OiNHzofthmOaVWaI8j2dBSai14mQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021)(921020)(4143699003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aExHSHRiTHpPQUt3US9VeE1JVXprVnJBNmVlb0g3L3lyZ1IrRldLSnp4RlU3?=
 =?utf-8?B?cTdlWFRKSktVZ0tWU2N1ZnFrRmJPYlhDWm9tYmgyRUpTVW9rQmtFbWJPL2RH?=
 =?utf-8?B?bVFRTUl6TzZyTngvdkp2dWdqUHk2bndXWThielRHOHNuZ05Id0drcjJwWWc1?=
 =?utf-8?B?Tzk0ZDF3Rk42MUl0c0orTWEvRnpyb0w3a2c0UDQ3UWp6bUpRc2t2SzlDQTli?=
 =?utf-8?B?T3JNbENqM1VNT3RJa3dPcUJZUXJrTFdFKzM4L1hCMEtJcnV1NjZLN3N0RGxo?=
 =?utf-8?B?cm1mWFFza1l2bExkZG8rc3VxWjFIaGJrY2doUTRpOC9XaFE3NUJaZUEycitW?=
 =?utf-8?B?UjZPQy9tdzd6SzViTFgxMnJyQmpLVlRnTDlwN1hoTG5KZGJsbXAyUmRIZyt4?=
 =?utf-8?B?SlFxOGxLUUZ3ZGs4NmoyNGJlaGt3ekhjaWg0Vm1haFh0Nmd6aEcrYTA1MkxN?=
 =?utf-8?B?d3NUeDcwR01OQVFJSjd0VnBOaE1NZHRCVVBsTURSMWFpb3pCQXZhZ3AzaVND?=
 =?utf-8?B?cXRRRUdjZ3pyc2pjMU0zMVR4YWgwdm11bmwxWnpCL2EvQXpBYTVKNFp0cjFS?=
 =?utf-8?B?eU12VTNmRkZxcCsyVGZFeFJuRm4xL0dNQVgzSDRPOGdJS1YzUHJHU3YvdS9a?=
 =?utf-8?B?OVEwS0RCSU4wS1I5blNkaDh1SzY3WmszdUt0b3h1Qm5VVjllL0lnNk9wMFQ4?=
 =?utf-8?B?OVZrdTcwSmVVcUlaL01GZWRtT01NNmdjd21lVEZSOGFCc3NvdnBXTXNtM0Zz?=
 =?utf-8?B?ek1NQTV4cndiWGZtcEswVVpsYWZzcHR0dnVFQzNvSWlPNi9IQW04T1BSU2dw?=
 =?utf-8?B?R2VsenppYjRiblBPbitvUzVsTUhlWVRFcjNtR3pOazFEbU9COERIMTBPVUxZ?=
 =?utf-8?B?MUcwWVR1UG1MWHBTRnhvMUFPTzBSbVZEN1g1VDk1S2Q0MWRELzliK1NDZ3k4?=
 =?utf-8?B?MUNCVjkzNjl5dnBsWVlySWFnT1c4NFdrWExQaGROM3M0a2pyQjVWMzM0eUlI?=
 =?utf-8?B?THgyYkFWREVGVXF2NGprWXM5WmRKUWNPZjhYdjAwS29VNWd4bHBkRExQWm9n?=
 =?utf-8?B?Vjh6a21uOXcxeXJ1NkRsZzBpUm5KMWZaazFXYVN4RFMxZmNVcUM5QXhrYXo2?=
 =?utf-8?B?NVMxbHFpOVhtOGc0MUVlSmZMM2d2cnRoUzlXTGhFTHVsSTVGcTZ0bEVlMnZi?=
 =?utf-8?B?ZVAvNlR4dU1Ieng0MWt4THoyVC9BVEdSbDZpRVVmbi9hVERrQjNuMHhDbVVt?=
 =?utf-8?B?NEpHcTlJRTdiVVFnYldxcWo4Zy94ZkJsMUU4OGduN0NzNHYwU0xYdks0RG5E?=
 =?utf-8?B?ZjV4WnFaR1FWSGVHdjEwVXVQd3ZUN3hSczVZRHZvME5vSXRXZERuYU1JUmhT?=
 =?utf-8?B?b00zdzdhZ2FiY29PeGVFRmR2dTJLRXJTRUxQeGxQZUZUK0VpblVKa2NMbTVX?=
 =?utf-8?B?eVNIREdQTTdIUjdCZFE5TDI2NWt0S29JUVdrZThvS3Z3Y1lrckdLcUtxdUFR?=
 =?utf-8?B?RVY3QTcwN1hINWZYZUhOK2V1SS9udmtrc001Vmd4c0Y4Y1lXMWNYVXYvVmxl?=
 =?utf-8?B?L0UzbnZpSTNjZHowSzBxdzVWYk4zNWxlaGpVOEgwQVZWVVNOSXUvUlpQUFla?=
 =?utf-8?B?eWttMzNZTDdMS3dSbDFzTElZT2dNZHowd3h0UkhiQk5MUmQ4ZG5jc05wb2pD?=
 =?utf-8?B?bmpvZ0pvbGt0am1Wb1RLRlgwYXV5cEJDQVZGK1k5a1lhQUZxNFV0TFJ0akc1?=
 =?utf-8?B?MjBuaHh2M0dZZmpMa0I4ZmQvbjVmMG5aWjBNQ0pQMFNmNThINFhrbHNtbGU0?=
 =?utf-8?B?bWttSXhBSE1paHVwT3BoY1Nyc3FMWWFWV0FndU14aVJDMzFXUTROSjEvRnB3?=
 =?utf-8?B?dDJiVTB5MkdiMUtuSDh4SHp6WkNNRHNkbGtXbm54V1BZeG1FVGtlUUQ4eE5V?=
 =?utf-8?B?RXBvZ25aUXMwRU9qdUVSQ1lnZFNrYysvWWYwMGZobG1DUlVnQlR5bHhIeThN?=
 =?utf-8?B?anZEUlBhelc4Mll1QzV5SlJiU0dmcjAxdmJwKzFKejA2bEpJaTJQbUhWc2Zw?=
 =?utf-8?B?MTlKbVRybXFERjU4em41aVFsRFVqNVdpUVVPR3dGVUl0UTdZVUFHaU42YTRB?=
 =?utf-8?B?c1ptUXJEek1YVTFoSXErYUNKTFZwck9OdVNrSjc3aGxiOW1NclJFNkFPS1B4?=
 =?utf-8?B?MWwreVd6UzV0YWVLUC9CQ0x3dnREWnhVYkc2MXRLSUt1Zkt4QkkycGZxMmdT?=
 =?utf-8?B?OFdSVHJZdWE3ZlM5cFYrQWprNmtuN0JOYTJWbkRiTjhGMklUUWRLLzByeHpi?=
 =?utf-8?Q?O6oEZ/4eX7hCcsCK5O?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	JOiNMpNnHgHSJmFgfvVIUFRge2zV3NV91tVTLVwyAhsOuhpZi1nL5KJFbQtTgYGRmNbi2cM5/YkfbONWUEkCD07dCUPU9WK8+25z5svP744v73rVtQXIYsJ1eo/yNBoyU+Sshhmech/TbtCFq3wrp6nlU7HfvpHRBJRN0Gqr7A5a2+1SxcB/l7avpCqdb8r70nfmLVezvYeIZEoppCa5iupThurkbXV4HgZBArlJaSJzlO8/DTL4DxTTHet+omPW+Z8QhkVbrNeolKYjjnrKAo/vmpcvvnTP1Hda/EODlgF0FIL5BysWz+JofgqH0ocBhQ2S6AOX+/1ZtjV4x7ACAA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061a31d9-7bca-4a43-1ed2-08deb4ee1c59
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 14:59:50.3655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wdzlz7lxSD4SZYmSFoxFXpsFh5AzqBkLLh5Iv9wfkbEIxjB49lA5N9gmivg/vuTrvfALs5P0LPZ2ES+xKWxzYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR03MB8446
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE0NyBTYWx0ZWRfXwEwV/yD7GV2u
 heWXcS+9mJ+2G6g4JdTXHtAd635T8i3j7JAOttD+cT0fQSGw6WZqOMWz0ivnP4PZmi0uiNBKtzh
 jv4EBJ0O8pni+Vvp5ZKyYdV8DfddikNOx8uwF4QSUyZrDQdVpCqOi4SuoWdy4Bdu76zyw9r3euO
 lt3kRYK+tfVSw64v+OgQ+K1bK37FKfq7Q6gfkC7kcpJkAEZ7yNLaFL6R+7tyoDxbZGDlTtNXbQp
 TTtsVVbx7s2Y9lvuMKrIDsztM5TADPQl0sgGAJH6yohNnp5x2IENL7TRKrI3wZFII4mOwIBwoko
 PUPZf4PtGcUhnHksGF/bGCgqGT+MfUB644JJ0BIsMdBg6Z2qh8v3bzZSNmjcNfVnMWe+SvP9fEW
 f8EDrae5JpW3lL5PkeqxA0nvm1YJAHl2vWE/cOz9NAxauXjfRySeaR48zWy9uR5edp4502bsUlT
 Ly9Ug1G1fYE8XpPpdaQ==
X-Proofpoint-GUID: Z5WgRwJ-oddLxoE6YHwHcHiNaVlk7K_H
X-Proofpoint-ORIG-GUID: Z5WgRwJ-oddLxoE6YHwHcHiNaVlk7K_H
X-Authority-Analysis: v=2.4 cv=QpFuG1yd c=1 sm=1 tr=0 ts=6a0b296b cx=c_pps
 a=R7TnPQtMnhj+722GCxzAsw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=IpJZQVW2AAAA:8 a=h0wPHuA3Y5puwjDpgRQA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180147
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8966-lists,linux-pwm=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[analog.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BC6AB56F818
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBMZWNobmVyIDxkbGVj
aG5lckBiYXlsaWJyZS5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBNYXkgMTYsIDIwMjYgODoxMSBQ
TQ0KDQouLi4NCg0KPiA+ICtzdGF0aWMgaW50IGFkNDY5MV9yZWdfcmVhZCh2b2lkICpjb250ZXh0
LCB1bnNpZ25lZCBpbnQgcmVnLCB1bnNpZ25lZCBpbnQNCj4gKnZhbCkNCj4gPiArew0KPiA+ICsJ
c3RydWN0IHNwaV9kZXZpY2UgKnNwaSA9IGNvbnRleHQ7DQo+ID4gKwl1OCB0eFsyXSwgcnhbNF07
DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCS8qIFNldCBiaXQgMTUgdG8gbWFyayB0aGUg
b3BlcmF0aW9uIGFzIFJFQUQuICovDQo+IA0KPiBDYW4ndCB3ZSBqdXN0IHNldCByZWFkX2ZsYWdf
bWFzayBpbiB0aGUgcmVnbWFwIGNvbmZpZz8NCj4gDQoNCkFzIGZhciBhcyBJIGNhbiB0ZWxsIHJl
YWRfZmxhZ19tYXNrIGlzIGFwcGxpZWQgYnkgdGhlIHN0YW5kYXJkIFNQSSByZWdtYXAgYnVzDQpi
YWNrZW5kLCB3aGljaCBjb25zdHJ1Y3RzIGFuZCBzZW5kcyB0aGUgYWRkcmVzcyBieXRlIGl0c2Vs
ZiBiZWZvcmUgcmVhZGluZw0KdGhlIHJlc3BvbnNlLiBXaGVuIHVzaW5nIGRldm1fcmVnbWFwX2lu
aXQoKSB3aXRoIGN1c3RvbSByZWdfcmVhZC9yZWdfd3JpdGUNCmNhbGxiYWNrcywgdGhlIHJlZ21h
cCBjb3JlIGNhbGxzIHRob3NlIGNhbGxiYWNrcyBkaXJlY3RseSB3aXRoIHRoZSByYXcgcmVnaXN0
ZXINCmFkZHJlc3MgLSBpdCBuZXZlciB0b3VjaGVzIHJlYWRfZmxhZ19tYXNrLg0KDQo+ID4gKwlw
dXRfdW5hbGlnbmVkX2JlMTYoMHg4MDAwIHwgcmVnLCB0eCk7DQo+ID4gKw0KPiA+ICsJc3dpdGNo
IChyZWcpIHsNCj4gPiArCWNhc2UgMCAuLi4gQUQ0NjkxX09TQ19GUkVRX1JFRzoNCj4gPiArCWNh
c2UgQUQ0NjkxX1NQQVJFX0NPTlRST0wgLi4uIEFENDY5MV9BQ0NfTUFTS19SRUcgLSAxOg0KDQou
Li4NCg0KPiA+ICtzdGF0aWMgaW50IGFkNDY5MV93cml0ZV9yYXcoc3RydWN0IGlpb19kZXYgKmlu
ZGlvX2RldiwNCj4gPiArCQkJICAgIHN0cnVjdCBpaW9fY2hhbl9zcGVjIGNvbnN0ICpjaGFuLA0K
PiA+ICsJCQkgICAgaW50IHZhbCwgaW50IHZhbDIsIGxvbmcgbWFzaykNCj4gPiArew0KPiA+ICsJ
c3dpdGNoIChtYXNrKSB7DQo+ID4gKwljYXNlIElJT19DSEFOX0lORk9fU0FNUF9GUkVROg0KPiAN
Cj4gU2hvdWxkIHdlIGFxdWlyZSBkaXJlY3QgbW9kZSBzbyB0aGF0IHdlIGNhbid0IGNoYW5nZSB0
aGUgcmF0ZSBkdXJpbmcNCj4gYnVmZmVyZWQgcmVhZD8NCj4gDQoNCkl0IGlzIGluIHNldF9zYW1w
bGluZ19mcmVxIGFscmVhZHkuIERvIHlvdSB0aGluayBpdCB3b3VsZCBtYWtlIG1vcmUgc2Vuc2UN
CnRvIG1vdmUgaXQgaGVyZSBpbiBvcmRlciB0byBoZWxwIHJlYWRhYmlsaXR5Pw0KDQo=


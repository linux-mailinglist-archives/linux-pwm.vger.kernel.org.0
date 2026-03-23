Return-Path: <linux-pwm+bounces-8343-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFC6FksDwWlUPgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8343-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 10:09:31 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6652EEB9C
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 10:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20BFD301AA9D
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 09:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEEA38644B;
	Mon, 23 Mar 2026 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1kSdkZiG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68983859FB;
	Mon, 23 Mar 2026 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774256656; cv=fail; b=hD1LplUWvMNmsCLBpJOk4OmAYKEub0JLTPQNnYYhTlNit6RDahMEDiIo2mEtRmrF7PrLr/q4rW6WnOqiq/zW44KN/aZY9ivboQlXXrG4jETjmVcSSK+N+vOFzYD7hUUfFVUzjs1D7smB9pFpHi5QGq/HEC1QOQVbxQxPFFImJOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774256656; c=relaxed/simple;
	bh=TBcf8/sy8hRQNxAmC0aYrDKHi3kjXoO1KIVeiA9YhH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AlIsIGDjuWkXTL7XoYawlh7cWiIPaeQxLPYRIHPdPhtxt85oaAntPIxmLCEXGPQn0JE8mlGvs5WiHAXJVC9W6FSU8q6qRShJRFHSTTdALAWv32MEE3cHjp4zRG+FbWNvMaCo8nmnQMm8ePE/98jxSrAv4M18T0bURvfrOoniTxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1kSdkZiG; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N4Z4wI662599;
	Mon, 23 Mar 2026 05:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TBcf8
	/sy8hRQNxAmC0aYrDKHi3kjXoO1KIVeiA9YhH0=; b=1kSdkZiG6GNL1maaXot4i
	egD8PrSNiIVec44LC8lLWFqQU7t+hcxNHZowd1tuLA3MmPTO+MxIfPfG3lPbo21d
	aR1lIEnqkZQ9Vgztd/tgRkR3hPMkO1ENKS6VZbol+9KawfSJvYjIVlCxn1AEkiGV
	mUkixF5Aopmu40it/PQ+zQt3HP/oNwHulaO6g1pO8VzjyB9e5rkUjCDyZN10pEwe
	Bnpkd0t7PaYS/eRDI4tQc99cWTNCTMVNS+sQDXGVa5ZpjkE4EHv+GVJGw7yiziFH
	Uwpx3igRKfncA55VOFCRGeg0PJnw/eLrjuhTsddo49/BWQcqyLd4OXax2YEJ4TIN
	Q==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d1n61xwuh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 05:03:41 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANbJGahFyXuXrNVvdi5U36wPZ2Fun2H3fipugaNiK5i1IdrapIo3c9PYpzGbhMk/lSwmQECK8IxlurwdrRSgnKr3uRVq7qNpC3Gxg7RWdDmAlZcv7EOHM5K10MT5aQclaPehDiPUYYYsMouAV8QSVeNtfZ+NwSTrCTShEq+9uJu007PvWFGKFDyFJg+pHgaNPIb1pK7CeqhZZvQ/ZN1LtOLPPG+DtCFlqidwMSnQln3nuVGPBuj4yupv+C2FS662wVzcrg68ld4wAt18RF//h9uhgCfPXfYol/M79bMXr0FcLWf/Xc4CsES90R0ed7oAbvCI5TgF3KdZW9C4mJjsqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBcf8/sy8hRQNxAmC0aYrDKHi3kjXoO1KIVeiA9YhH0=;
 b=NIA79st3lgIiW2lI5p3YSc/taVpatSSogikkT/8BdHvCWeXAD/mIWGd9c1Q1ONKtVewNYbCfdEp2ckorUAcU8zs0xpnhQFeupMNFv/Y6LmqvAS9Afk3qL6jpmuO/HqqBOoxhcosH4ljhuTNXxB3fTAkhVy0xdVtb1R3aNOzC2MrOALKGqVfir/YZpvOSIO8luCHt5lE7PEz2GRYdvs2W/MbmOybSsccv3KJL684zkOwnQP60isTJ1ugUE49r8Kn80Bf3H+/dy5cv9S0nFCU6vqDoqpNVeG2EDydXyLC5cRoFepKXj2fy6cR881aObPXUlbJJpjjmNFMpaiVPEoY/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by CO1PR03MB5811.namprd03.prod.outlook.com (2603:10b6:303:91::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Mon, 23 Mar
 2026 09:03:17 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 09:03:23 +0000
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
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [PATCH v4 3/4] iio: adc: ad4691: add triggered buffer support
Thread-Topic: [PATCH v4 3/4] iio: adc: ad4691: add triggered buffer support
Thread-Index: AQHcuFlEE/Kp5w+npk+HoCBYC6Jbw7W5GrwAgAK3opA=
Date: Mon, 23 Mar 2026 09:03:23 +0000
Message-ID:
 <LV9PR03MB841408C5B6A26B45758CE2EEF74BA@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
	<20260320-ad4692-multichannel-sar-adc-driver-v4-3-052c1050507a@analog.com>
 <20260321151640.4dae9b91@jic23-huawei>
In-Reply-To: <20260321151640.4dae9b91@jic23-huawei>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|CO1PR03MB5811:EE_
x-ms-office365-filtering-correlation-id: 39fbd947-8e85-44a8-5d2a-08de88bb09cc
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 shn4XpY00sSeOdxwa/wgLVHeOJ7JWK0xJ+4tppYZ8fRw5R8A7d8Ed+EYS69Fq0axJRk5blUVB4eOjA50wDo3MCoamNXTFLX+9VOOBLdUwucDsqR+J43lWo0rSOQ6Tnu1C3e9rpSf22F9M/QPNm5bidbcXErkKGSlF2vo5XGy9Ni3pN3cPr1f7tiUSAEiRMBvhHnYULkPOmh2z07v7/Ggkl7951q2KUk6zbqooFLTtwLtLWeeEIsxF3GokGkcyddq/CB1E7KHPyUeZ/sNqWYlLACMAMFHPeRbO+CaXZEFzse/eZwNXgjhVFB7DsdQFDqGESv7evchmYVKqhKvXSe7Q97mNqcOFdLX71s46XTzCfLvReHOWGKG2f3dNWOvSGGR2L2kfOicSy0iCb5rhjK5zvaPyVYaYeFrqbBJxfsQMsmf0+01mYI1rKvQxWJyqkbj3zIgY8iJpI5fw2rJM0aX7xuzq3g/VCnpcqaZT54eCKpIT00dDBYqCZHmJHSw7LX/K9NtJs8K9mN8s3WZdpryuj1Xp+PAH2M6q4+q3+47VFHcVe/gJZ1OrBJt+/OCPt7IJC0BjnjrdTBCuhbnZ6HJWhY3H33QMFVuGINONOv3j2HsQ8X50Xuijq+6qxsD6joTIHIPaQ6mm6xjprmEUVD2612cBq0DeFHSsVryjHq8e5BTKA/bd8e0r49U2BSjgBtUmA+aB7vLCpfJEyZ7iZBj+21YZZY7TZWpk1eU0hW7rmGYgvLrlIWoQcsYgqHrBqxAcRWgakUWieQXcm+B2iJ9AiHmKVbnrGB1vOnuit2cZOk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUFTZksrWnd4L1UyUitJUXN5QXhXeVlCOTMvbW1NOEI0dklpZTNaNVJOUTg5?=
 =?utf-8?B?UnVZcXg1UFhLVFh2elZ0K1RlWEp6Z1dxWXdMSUNTeEZVcEVWR1FtdmhmUzB1?=
 =?utf-8?B?SHhKS3dqdHlMajdCVS9DUFU3T1V1ZWRKOHVQMEJxeU9ZZHNJbTBVYWVwYkdn?=
 =?utf-8?B?bHpXWFJRbGRZS0FmRjNmTWNIMHUrQzRRU25EeHhSUlN0Uk5JRkxZSzJtQWxu?=
 =?utf-8?B?K2RRUWIrNzNjd3YvZ1o0TXhhcGF6NlIraHk1T3VqYjhIYkEwZFNucEhKbkQ5?=
 =?utf-8?B?V05hcWJudWlQZTBJWjRRbUlhQTdzTXFiYVcyUUl5V0dCWm4raTI1bE5BYXp0?=
 =?utf-8?B?MytOa0ZqV05zRnJ4TmlGVWdzL2ZlNTJNL2VWaG1YMy8wNXVKajlKdHlaMVpV?=
 =?utf-8?B?ZGlpd29iN0owc1dyUFQ3Z3hFb0o4UGF5bEpkMWJ6bUhDYk5tNXNuQ09GYVVU?=
 =?utf-8?B?d1FRMEtJb0NkdXdnQTVScXplc2Y0dHIrMWQ0YlpRRG1MY3ZZdTVsY214ZGo0?=
 =?utf-8?B?TjFoYnd4UHl0ZVFHZDRoRUlST1JNTWp0TXIwQlIxeXo4bjBvNENCdVA1RXZs?=
 =?utf-8?B?OEhGSm9kMGJuQk91bnJOOEJ4TGpsMUdXOFkwZy9LdnpmM08zeEJGV0RGOEQx?=
 =?utf-8?B?eXRRNDNhS2dLSmZrVm1vSHJzR1Q0ZlNCclZGUUZkUEY5aUt0cGEvYnBjSTJo?=
 =?utf-8?B?L2JScFRGKzdSZUJNdnN0WnRyVmJBZ1FjNmhPdkdMOW5QODl0Y1dsTEQrSlhv?=
 =?utf-8?B?NUNLZEhkTE9tbGxyYnJpVERJREtNMjZRTFVqbUJVbzdCS2hPR0VrKzZ4cjFu?=
 =?utf-8?B?KzYySVd4cjd6eHQ5T0xsLzRXeVc3V1VPT1Y4OTVSMXl5OXM5bUxkdFdPUGRO?=
 =?utf-8?B?TWczaFpSL1FBelM5MFFMRi9UQlpjSmFsTzh3bHFEZDlkeUViaFRJQ1lTZVNk?=
 =?utf-8?B?V0s0R29rR0crZFN0a1RHeGNROHBtb1h4NGU4S2tKWUZvOHo2bGI2bENsYjRz?=
 =?utf-8?B?VnJVRkJwR2Nid2VudVdtWGd4U1hYa2tCTEg0b2djN2FHR0VaSnlFY0oxQTQ3?=
 =?utf-8?B?U0pHdFdWeWljYmkrUm5zRE1DSG9sUXptZGpmMHdWTVN6YkN4SXBzdWdYRy9z?=
 =?utf-8?B?OWlNMGNVQlR5dm1EaW4yd1E2eE54VTlaMlNvK0V5ZEErWjJUdm8wcTZ6UEFF?=
 =?utf-8?B?N0duOGt1M2dXcXhXOFprZU94cDdqTlYxeWZSRy9KcHoyRThUK1V5aVB3VU5w?=
 =?utf-8?B?dzU2eitsUWMzK2dBdU43OGozczZCUUI2T1VOKzNaUWNOdEtJN3BhTGJmMmRV?=
 =?utf-8?B?WmE0Ui9FWmU2azhKb2pSTFVyK0Z0OUg4QnJGTFlldmZ5TXNYZTBjc1pxMjI0?=
 =?utf-8?B?cDZpbEJLRStkNDNJODlJK0RUYndmeW1Gbm5XWFpZN2dXb1MvbnVoZk0rK09P?=
 =?utf-8?B?M3RWQjdueUI2NVFZcmdaRlNpeFZFS1J6MEMvc1FjNVRZNUZtL1NYM2ZKbk5t?=
 =?utf-8?B?YmtyT0ZtRXZGSVZ0Rnh1OXY3MTJNbFkvQys5Vmd1alJFOFdWeXVMbnhkWWdi?=
 =?utf-8?B?QlBDb3VGWHhqcjlWNEUvUTZmbldRLzRsVVlpczdpYkRlbVF0Z2gwWWt3K3Z4?=
 =?utf-8?B?M1A4emhPdG5jZENmRGFVejFBa3hpTmtlZTN3eHNhbGlLSUZGNUlKNkg1VDlo?=
 =?utf-8?B?enk4NDh0WGZKVitqOGZBOS9YaXpkZWtFeSswRGxoL0x1b3Y4NzVJV1R6T0dl?=
 =?utf-8?B?VDBEVnRCY09QRHplZWV5ZFlhbks0cTM1VlU5TnQrYWFwTnJ2VDc5TWF2akQx?=
 =?utf-8?B?VW5xRXNLdElLelF5MmxCb3FtT2xURWk0MUYxRXg4ZUgvSTNKOEpPSDhPWVh2?=
 =?utf-8?B?UmczejNyMDRud3lKYnBuVlBHMnhCNDNXYjNRbGZ0N1F4SnVnOUFTanN4VXkx?=
 =?utf-8?B?eUNHQS9UVkpDUEo2b2k4MCs0cWRTbTVzQkNpZ09HSnVWa1JPRm5mSEdjaFlw?=
 =?utf-8?B?eFJyei90MmMyL21aVmc0cXJJSXJua3ZIejBkQVhQbEkxMnhtLytFZE1kS1pJ?=
 =?utf-8?B?RFZyTTJRem90dXo1bU5mQnRGRVRFZnZYODNOYXQraThBWGFtTm1IQkJHTk9V?=
 =?utf-8?B?dlRlYmMvWlBEc3JQKzZHd3ZxeENyVzNTTkRoaFhySmtSVG5jWVcra2IrdU5I?=
 =?utf-8?B?K3B6RjlUN2lqS1dZa0xhTFVTRlJGVnpVNGQ0SXhBK2dVcGtSdDNFSHRnU3Bu?=
 =?utf-8?B?bFNHQjlqV0ZKVVlCdTZCaFJMV2dtTzh3azhzQjJqc0R4SlB0RllCU0VrWWlP?=
 =?utf-8?Q?rrUl3vHFRC7ARwkJMx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	LgC3y5ZKvHSv17qzw/cpKTC/NmeIKXhTqumm19lrYtydJNEfnMPGt/tmlDBVZ0AHtZCggGvIUqvEVY2gNsvcQhv+PYViZXrBDfGY+YuY/crTRUWm7WP9z9PhkBF0LpHz25knbuLfAEFwIp349TWDYKPOscH9lqkh1LutIhqyq8vdeUul0I/+Fhgig+iZx4rjNKq2VdoqIIyWP9TlYugCkWlz8dd4pwXDeFYxAl/w6bXichaswgEhnAO28+zdVitBxyJR4X0eC0ILrgf+XJdY5WMI4L0OswoNBFyJeNeIInFW4bJj54OBzGhmP1y461Zfnsx1KMkhJJ7f+TWTX51Ciw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fbd947-8e85-44a8-5d2a-08de88bb09cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 09:03:23.6769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qiTSNyT3VltA2FwHFkStEJGcJjZwaXwJM005CRO5hD9JtgvGYByKrdeVildfykfsxA7/mGwg3Lh1xRlLpeKsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5811
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA2OSBTYWx0ZWRfX7L7tCnGsTupH
 1+THAY5gKAcsCZbWRbJKvSs853UxQN4D/buTy+EtlVogyZG+P0oG/ehhU256sEuuScJQ8z+BVSy
 2NzAWFzYoEYuvMBrQf5mPDGnni0163DGqf3MWs7Xzbf/Qwff+fwc99W4dLji+MSRROGfIxkykEO
 X9fzrDAKPGnCwIm10yckMm6X/lO9f8SSwMbKhRyX9y8h//++dxkhJu315JlL6fqDiSGngVpFTyq
 Yn/ZgcuMXfYbKaf+OfQAxDdjD6oN19MqEjTEO9PwLfzjGksAqtzxICmrEXnSbktKf2u2q+QtD7Y
 1yDSsDqrBS7RNSmAfl28DfANvejLw1qbCDyZoTl51Wi+W221+UOcU5QbtBGlhyzVtJ8kQZOicgN
 pXq9TZScEpva/wIzGaeC6mF4a9TiaCO5CE+7rn2UnEVETRUbo2MERwdMmOaJ91rdm13AMD/oBNS
 XYv92lX2PWKvQMaihgg==
X-Proofpoint-ORIG-GUID: vLpnZG9YI6Ku0ifaGs1oy8dlg0q3ooV2
X-Proofpoint-GUID: vLpnZG9YI6Ku0ifaGs1oy8dlg0q3ooV2
X-Authority-Analysis: v=2.4 cv=D59K6/Rj c=1 sm=1 tr=0 ts=69c101ed cx=c_pps
 a=26exYMEZoLJjBWxBNK6Yow==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=owKV7LhANKs259L-C-cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230069
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8343-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,LV9PR03MB8414.namprd03.prod.outlook.com:mid];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,baylibre.com,kernel.org,gmail.com,pengutronix.de,vger.kernel.org];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	NEURAL_HAM(-0.00)[-0.998];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CF6652EEB9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz4NCj4gU2VudDogU2F0dXJkYXksIE1hcmNoIDIxLCAyMDI2IDU6
MTcgUE0NCj4gVG86IFJhZHUgU2FiYXUgdmlhIEI0IFJlbGF5IDxkZXZudWxsK3JhZHUuc2FiYXUu
YW5hbG9nLmNvbUBrZXJuZWwub3JnPg0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4gT24gRnJpLCAy
MCBNYXIgMjAyNiAxMzowMzo1NyArMDIwMA0KPiBSYWR1IFNhYmF1IHZpYSBCNCBSZWxheSA8ZGV2
bnVsbCtyYWR1LnNhYmF1LmFuYWxvZy5jb21Aa2VybmVsLm9yZz4NCj4gd3JvdGU6DQo+IA0KPiA+
IEZyb206IFJhZHUgU2FiYXUgPHJhZHUuc2FiYXVAYW5hbG9nLmNvbT4NCj4gPg0KDQouLi4NCg0K
PiA+IHRyZWUgaXMgY29uZmlndXJlZCBhcyBEQVRBX1JFQURZIG91dHB1dC4gVGhlIElSUSBoYW5k
bGVyIHN0b3BzDQo+ID4gY29udmVyc2lvbnMgYW5kIGZpcmVzIHRoZSBJSU8gdHJpZ2dlcjsgdGhl
IHRyaWdnZXIgaGFuZGxlciBleGVjdXRlcyBhDQo+ID4gcHJlLWJ1aWx0IFNQSSBtZXNzYWdlIHRo
YXQgcmVhZHMgYWxsIGFjdGl2ZSBjaGFubmVscyBmcm9tIHRoZSBBVkdfSU4NCj4gPiBhY2N1bXVs
YXRvciByZWdpc3RlcnMgYW5kIHRoZW4gcmVzZXRzIGFjY3VtdWxhdG9yIHN0YXRlIGFuZCByZXN0
YXJ0cw0KPiA+IGNvbnZlcnNpb25zIGZvciB0aGUgbmV4dCBjeWNsZS4NCj4gDQo+IE5vIG92ZXJz
YW1wbGluZyBjb25maWd1cmF0aW9uPyAgSWYgaXQncyBhIGZpeGVkIGxlbmd0aCBidXJzdCBJJ2Qg
c3RpbGwNCj4gZXhwZWN0IHRvIHNlZSBhbiBpbmRpY2F0aW9uIG9mIHdoYXQgaXQgaXMgYW5kIGlm
IHdlIGNhbiBmbGlwIGJhY2sgdG8NCj4gbm8gb3ZlcnNhbXBsaW5nIGJ5IGNoYW5naW5nIG1vZGUs
IHRoYXQgc2hvdWxkIGJlIG92ZXJzYW1wbGluZyA9PSAxLg0KPiBTZWVtcyB0aGVyZSBpcyBhIGRl
cHRoIHNldHRpbmcgZm9yIHRoZSBhdmVyYWdpbmcgZmlsdGVycywgdGhhdCBzdXBlcmZpY2lhbGx5
DQo+IGF0IGxlYXN0IGFwcGVhcnMgdG8gYmUgdGhlIHJpZ2h0IGNvbnRyb2wgZm9yIHRoaXMuDQo+
IA0KPiBTZWVtcyBsaWtlIHRoZXJlIGlzIGFuIFNQSSBidXJzdCBtb2RlIGFzIHdlbGw/ICBUaGF0
IGZlZWxzIGxpa2UgdmVyeQ0KPiBzdGFuZGFyZCBvdmVyc2FtcGxpbmcuDQo+IA0KDQpIaSBKb25h
dGhhbiwNCg0KWW91IGFyZSByaWdodCEgVGhvc2UgZGVwdGggcmVnaXN0ZXJzIHdoaWNoIEkgd3Jv
bmdseSBuYW1lIEFDQ19DT1VOVF9MSU1JVA0Kc3RpbGwgKG5hbWUgY2hhbmdlZCB1cG9uIGNoaXAn
cyByZWxlYXNlLCAgSSB3aWxsIGZpeCBpbiB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoZSBkcml2ZXIp
DQppbmRlZWQgd29yayBhcyBleHBlY3RlZC4NCg0KSSB2ZXJpZmllZCB0aGlzIHVzaW5nIGEgTG9n
aWMgQW5hbHl6ZXIgb24gdGhlIFNQSSBzaWduYWxzIGFuZCBHUCBpbnRlcnJ1cHQgdG8gdmVyaWZ5
DQp0aGUgdGltaW5nIC0+IEdQIGZhbGxzIGFmdGVyIGEgbG9uZ2VyIHRpbWUgaWYgZGVwdGggaXMg
aW5jcmVhc2VkIC0+IG92ZXJzYW1wbGluZyBpcyB1c2VkLg0KDQpTaW5jZSB0aGlzIHdvdWxkIGJl
IGEgbmljZSBhZGRpdGlvbiwgSSB3aWxsIGltcGxlbWVudCB0aGlzIHRoZW4gaW4gdGhlDQpuZXh0
IHZlcnNpb24uDQoNClRoYW5rIHlvdSBmb3IgdGhpcyENClJhZHUNCg0KPiA+DQo+ID4gTWFudWFs
IE1vZGU6IENOViBpcyB0aWVkIHRvIFNQSSBDUyBzbyBlYWNoIHRyYW5zZmVyIHNpbXVsdGFuZW91
c2x5DQo+ID4gcmVhZHMgdGhlIHByZXZpb3VzIHJlc3VsdCBhbmQgc3RhcnRzIHRoZSBuZXh0IGNv
bnZlcnNpb24gKHBpcGVsaW5lZA0KPiA+IE4rMSBzY2hlbWUpLiBBdCBwcmVlbmFibGUgdGltZSBh
IHByZS1idWlsdCwgb3B0aW1pc2VkIFNQSSBtZXNzYWdlIG9mDQo+ID4gTisxIHRyYW5zZmVycyBp
cyBjb25zdHJ1Y3RlZCAoTiBjaGFubmVsIHJlYWRzIHBsdXMgb25lIE5PT1AgdG8gZHJhaW4NCj4g
PiB0aGUgcGlwZWxpbmUpLiBUaGUgdHJpZ2dlciBoYW5kbGVyIGV4ZWN1dGVzIHRoZSBtZXNzYWdl
IGluIGEgc2luZ2xlDQo+ID4gc3BpX3N5bmMoKSBjYWxsIGFuZCBjb2xsZWN0cyB0aGUgcmVzdWx0
cy4gQW4gZXh0ZXJuYWwgdHJpZ2dlciAoZS5nLg0KPiA+IGlpby10cmlnLWhydGltZXIpIGlzIHJl
cXVpcmVkIHRvIGRyaXZlIHRoZSB0cmlnZ2VyIGF0IHRoZSBkZXNpcmVkDQo+ID4gc2FtcGxlIHJh
dGUuDQo+ID4NCg0K


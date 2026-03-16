Return-Path: <linux-pwm+bounces-8266-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N/UKsvvt2mfXQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8266-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 12:55:55 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FCE298FFF
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 12:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0376A301083F
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 11:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5947F392829;
	Mon, 16 Mar 2026 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="b3aQ1E1N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD0381B16;
	Mon, 16 Mar 2026 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773662141; cv=fail; b=K2z5UgU7hXllygds6cooNy184+3TtSZKzHlrV//mAlWMJR/xXHRgI4PYe7AcUWGAR0ST1f+H0qvJZy53q7DpbrHr0Krh68YIyucMVIpfq4dx88p0Ve158he1rP6ncSuxavQAzeLIWNXzD55uV4aQ37CxvtgkQA0QWdGCiLSIND4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773662141; c=relaxed/simple;
	bh=n4uV+j9mW3NejR9KY8VD6ChIXvsL3D9Z5pqeWTOr+9k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ijdc1ZWBbJMHpokbR8ipicPF77KyIYEj02kY0/Q6ylqpSUjMPcotT+zGi7UNTQONrHHafFQpkacwTB8F3+CHhu4/5ZJ9sjiLzmxHpjFx3imzUKS158AwdhZL0T/d9cUXt3burAuv7cO7G3wUBbKbGX3JDWrD+Oq4w2RE161zyH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=b3aQ1E1N; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GBFnAC1348744;
	Mon, 16 Mar 2026 07:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=n4uV+
	j9mW3NejR9KY8VD6ChIXvsL3D9Z5pqeWTOr+9k=; b=b3aQ1E1NzjdVOLIS+04GP
	M6yghVEwt7F/mxjsBgW0EndxDNdhMBjuulXdX+fPJxjrWDrApDk55b7gBaXy+0TY
	vxve/O5a5yWyfRfYpkUij5P74BcasCPXtYzpVdZYeav1S5aCQtSLcukkmhmTpLQN
	xZZDfX62XEQ0qvCPuQoSTmRK8pHouzbj0oMADrbp4L/KGQg7Gv/ImEQkrar4pM4R
	nDxssn+oI8f1aprDrCFnj5EcEHg3zqpDR4yO+5n/TGTaawfYOTJ2FJHTaW9M0uMs
	Sa28gC7l/b02Pm5HetfClA0pwTz8Jikj/4pVfhbIiW/AUF6Je74NvHxJ4aQKiMpf
	g==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cx2dgavgg-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 07:55:18 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bw0YKK+Sjf7wgxoyNAkHb9QYIyUIUQtw97BKCOdGb+zfuxPg5rn8LXvyuDxDawcLtYDMz74OIhYsyfxShXRwDuXk4t7Oj8TLDZRVQKYdtCFY6XtsGmxteAGQhr0rIfspoTI2w9nJKk9FkFGJyBPrg/Bmq5vqrs03JQObFUbawmdLXE0HSpRmIFsaAzcNzSL7CYV8vjON2Gs4syDRfZ9o3y3X02czvqmdgnC+M9ZptqC9KcmxkkJMaakq3yUJFY9BnZTgJUMcgPgpbAo7l18+vVW2oy0do8Prr2VXLAvgmUUsyIr9ZySv7wrpUbB0tn4XiJZ09IHtQO4VONm6NBTZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4uV+j9mW3NejR9KY8VD6ChIXvsL3D9Z5pqeWTOr+9k=;
 b=UGKryXrRIkcJ0y4QvNlafyG39vjznZk/BqExTqh3RLZV3WXkPrLrDLRkDhszYoqp5FVDXR+Ikf+Lm0YpuqyEbPtH1PMKtA92FILAkBdgtU9IdtqHFNjcnhmC7FLvStRSleYt4v0R9ePQuFawUZ2I/r+b1u9gdQxoI30Eox8GJsAuvi+I607YOgdDfwazvA+bjstwA93PJjaVS4ToWBSxF7898dDFBNofF2Xnteo3tqax/e38Iq1OxdovhV7lyEmO41+4AzWp+p04Vorr8aMpsW1LBu/VPS8SSTrJoKLBcYRRoL/J7bDLbuVs94ZbehWVR3FdQXkdh2FdizGZYaiUPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by CH4PR03MB7602.namprd03.prod.outlook.com (2603:10b6:610:236::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 11:54:57 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 11:55:15 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
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
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Linus Walleij
	<linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>
Subject: RE: [PATCH v3 1/4] dt-bindings: iio: adc: add bindings for AD4691
 family
Thread-Topic: [PATCH v3 1/4] dt-bindings: iio: adc: add bindings for AD4691
 family
Thread-Index: AQHcstE/ku+BrpeHyk25hycFu2yGm7Wtx/AAgANJuAA=
Date: Mon, 16 Mar 2026 11:55:15 +0000
Message-ID:
 <LV9PR03MB8414387B3E784EFCD97B1682F740A@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-1-b4d14d81a181@analog.com>
 <20260314-resilient-colorful-myna-ecaeda@quoll>
In-Reply-To: <20260314-resilient-colorful-myna-ecaeda@quoll>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|CH4PR03MB7602:EE_
x-ms-office365-filtering-correlation-id: 0be92861-0992-4a39-2281-08de8352e319
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 HBZSw/NuQ/DpbkhUkdG054bOdO87DhaJnQL8vkBn4JvW/KvPKwR59Nop6WiyLQh1UDNYK0nz++tLLLx6eQQs4geMxeWkO6KIj1sjVLKMTsGTGeLbXHmGDuSl8gE1glxgUtyrME8Y3p6C3koQAGEqvUWnM+inlQkNz226hnDyNBs9BSgtUj2gSGezSMALomfrxGHOAmwIoM4jlQ6FBlkt6GXLSjIUF8VzS/oY/98ECmXAqiDVCCCOQoxoi3tMFUb82Ue7G6LmICADeyGHoDkrRWlxBSleNkkOutC/TqmepmJS90EtLlaNzetC78AaKS9I/iSSyZ1PjdWcEhn/Engaac2y9CmBABH8muv+Z5Kw2CJIMpt24e/YJ7X5zChcvRphjaV52alJq08SXWVY2cdYWADBFgb+37mYiF4sR250cYJnLTWSU+WXyNo+5NZ+XAkKGuSVwVqGCamWMi3aVhQi0ptPKA1WfEyZZWfiH9vg0TLl5O0dPEpHol2/CCraByJ48YH9k4L/cJ4KCSBtg+LSX/jpAV5+5Dm6OLdQyx5MZOF47ihvyag5OrNcKGUlW8NCo/U39u10qr15LOybNLAmyr2CRVUDRTdpJpMqGoqO+77mNIzkB6QcjhbrzgsF1ZVEr0CjH6Y28nHRkSy77dHvli4pj1LjoMQ68Qc98vZybcxnZaEcjFri3WordfknJTRSi4SxGVN8ifq9YS79pk82XZMbr2dh4hXQ2xl8t1cIssBkKmcrQHGtS9OSw4cIyEgB3qAp9DUbkXKu/QMWdauYiuQSBKfgSw1sKTJblAhw1xQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NzhqNjJxVGJibk1uem1kbkFqVG1MMDJHMkp2Nm5PdnU3eG5GRWRqbzBhVmxE?=
 =?utf-8?B?aTE5MnlFOTcvQXpGZ3V2N1BXUUNFcklIMUgyNkpxTEl4bFRDNjUxditJQlQx?=
 =?utf-8?B?MkhzcTF4eFJuTk9EbjFRMGJRQzBDT2dPTjRNQlh3YlFyYm9JUFZvR3BPeXI1?=
 =?utf-8?B?Skluc2p0dHFubnJqVFFDQTYxZS8xYm9BMTFSZVVXZm1VQ3UzMmxLT0c2UklC?=
 =?utf-8?B?Y05xYVR4ckhNMElqMi9ublJrczZJdWRZTjY3SDk0Sy9HN2ozYkVYUnNBeWp4?=
 =?utf-8?B?MVFmako2UlVzNFA3SUsxV2lIQ3VCMGR4U0VGSGFLNE5KRUIzYllGL0NlamdM?=
 =?utf-8?B?VVVZT0tyWGhGZ0QvaE9aZ2hSRGdxK0xYaC9DUjdWRUlRSThkVTBYOWVHR2lX?=
 =?utf-8?B?NUUwL1ZPcUdYOGFaRitVakt1WGl2ZEFzd1ROdU1WalBNdXVBeEY0MFM1QUVO?=
 =?utf-8?B?ZHhkVEd4MGd5UHl6d0VCTzZVN1hFWXBMR2FaL2FxMXpVQUg1VEdvK2NFeFhv?=
 =?utf-8?B?bUY0SitmZE9aQVRMRHY0R052NnJpbkxPcnV6RGpoMW92K05lNVlDVE55MWVr?=
 =?utf-8?B?WHMyUXZVSXZjeHFVWlJudm15QmN1T2tiWUxrRGVibTVoUG1LZE8wWjhXUFI0?=
 =?utf-8?B?Zk1LdHZuVEZRQkRXblVldGQ4SEpJakl0ZXdXT0ZEQ0dqdmVIOTVCMG5Kd0Fl?=
 =?utf-8?B?Tlc1TC8zTGVzVEVycis3T2wvSlJXTUdDNGdwbEZENnJHUDZyTXpGelMrbXhy?=
 =?utf-8?B?STFkV1dTdmhSaFcweEhaQ3lZNEhGWEtHQ0tJYzFoYy9yZUJheHk5N1BwSDdG?=
 =?utf-8?B?RVhWYVVMZnhGd0JjRUJIZXpjeTZGUDNyVGJmclNaOURCRGVmMFZtcmpGUE1Q?=
 =?utf-8?B?SEJIVjZrbHl2VXVNMmFjL0xLb05vRWlsaFBnd0twNWQrdVBvTmNjMEFXR2VP?=
 =?utf-8?B?cU02ZFZMdHJySndMc2xFRkIwQ2E0WkYwelVGblN0QmtyeFFVamM2S1g0bW9X?=
 =?utf-8?B?N3VhTjg5M1AwWVNzSkJNZVVOdTJWamZqUDkvY2lpc3ZFQ1hBSVdObVQ5TExw?=
 =?utf-8?B?NDA2czJZT1ordUQ3STU0b3p1WFdyWWNpc2dEL0NSZmRjWmFONk9XcXZaQmgz?=
 =?utf-8?B?N0pvaFFEQTFwSWxqdW8yWGd5N0dpM3BXVkpzd1dUUzMzT1UwR3QxcU9oUXZu?=
 =?utf-8?B?S2J6MFVLeHpuQkg4RVg1L0VZS1FDc2JWMU5YT3p0T3M0cDU3L1FXT3YzbUYr?=
 =?utf-8?B?QUxpYjRWTmI5c0FHeVRRdXpVbEtQSUpKbWp1Snhtek1UYTBGNW9LK0dlcEpl?=
 =?utf-8?B?ZUNJRzZSZ3l0ZmM0TUNZUjQ0aHpJQUQ4bzJob2lJT1UzakJ0R09wZDRwOWJv?=
 =?utf-8?B?bnlOSVBJTGp4VmdhQW9IallndkNMNWI3bWU2Q3FVcGRraGRoOWhkMFkyNVdz?=
 =?utf-8?B?eXJSZzE5eXNaa3dKV2pwcEhyb0Z0dHFKNnhMVUpEcis1R0NIcHFQRXczcmJa?=
 =?utf-8?B?OHFrVlJGSGFScjlLZFkwczErNVNZejQrL242elFlVnZZZVAzZXkyREUzM0pm?=
 =?utf-8?B?UU5iOFl4aW0rZjFYL0VSQjkzZENIKzhCU3F0WHlBNW9WeHVZVGI5NjBpeWZs?=
 =?utf-8?B?T2FFTm1mME44QjlleHIxNEpCRUMrN01pM295SFVMVEJVSmNKOWVnYXphRTZN?=
 =?utf-8?B?MHFRcERpQkkvcS9GTTRwNTRXQ0NKdWVISkk0UmdIQkNhdis2TFNxSGZlMlg5?=
 =?utf-8?B?b3BKa1FOS3VoaThsKzJ1amIvRzVjMjQwLzNMc0hndi9sNU5SeVV4NEtMQTZJ?=
 =?utf-8?B?TGxVcXVRbnRMbVN4cXhHRE9UNGFZbTkyK2ZUN1IxMUp4WW1teFFBUWdBRHls?=
 =?utf-8?B?STRvbjZSMktBK1dTMzU0NlBrb1FFMWVnOVRZRGxobTlxdDZEallQdEtGOUF6?=
 =?utf-8?B?VVloZzNZMVpRayt5U3B0UmMza3F1Snk1QWhYeGMwS1BVaEhmUjBBRStKekhi?=
 =?utf-8?B?MUhvZkNHamp6VFZnaXlSRXZuMWVyeFlXcWNhQVMrMk5NeDBtVnlHdjA5c0w3?=
 =?utf-8?B?Q01LL25WL0xwK1NoQ0hqTlVCUnpIZ0tFUUNTT2NCNkVsTDkvcG9TSkxSMmFG?=
 =?utf-8?B?d01xUjRlRFAwWCtTSmNLdnRkdmhFdHlRbXRmYjN2MkRhUjRobE0rYi9QQkJP?=
 =?utf-8?B?QVR0N1ZNVnBzTnNNUllaUG1VOGliNDMzV05nWXVid3lmSHNJaGxpMjlwaHhJ?=
 =?utf-8?B?eDhITGhsMGlFWEhlRTJ2amFlL0E5OWg3Y0pWT2I3UHR2ZkhkUUYraE5CZEZK?=
 =?utf-8?B?Q01JR3p5dnV1TGxzZjJHZU0xV2taTTRSQjhWS0toZWVDSWtlMWNMQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	L5k8bcyxWvcejp2D4N92YfQEWchGyYSPv/LJ2Y8uetMrqVrmMkUEEaz8stlH26ZFKi6TGV28OpWdsB8JqqtfbStjtPwa9oeBpD8NlnCXsqrAI8qrg0Fw4z7tarOPgGApnreFCBnSbvhENrcy138pLl09pQlC5qLl3/gG7I6CYy7e21C3B5damr/w0tMq26kUPFChBYqzEIdTUvqo9M2VU9j+by22n++YIYIJLHsBFLKV4kvIKiWO/AZfU5xOvrWC/UoRzgaFQS0qkgcwcN/NjgGx54NfvVZZfNmUTyfOoRxotvtcKHxLkf8EjrXpKc6OWGoXnm3OCyIrEUS+EoyG2w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be92861-0992-4a39-2281-08de8352e319
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 11:55:15.3397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z8mh9skHPUAwtpX61hyaqnUZb2H4KQI6GgMbtBVFqKZKtnASaYUznMEkE/dXDnnPrWdTxnVv/lk52H8DOZGbpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7602
X-Proofpoint-GUID: Dc72jfe87kw-vLCuP_q5W7yjPhHFWwOP
X-Proofpoint-ORIG-GUID: Dc72jfe87kw-vLCuP_q5W7yjPhHFWwOP
X-Authority-Analysis: v=2.4 cv=Mb9hep/f c=1 sm=1 tr=0 ts=69b7efa6 cx=c_pps
 a=LawZwnZ+dX5EiMlPDlYRuw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=pGLkceISAAAA:8 a=RhNgNdMe_OAQXsAIQhgA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5MSBTYWx0ZWRfXx8/9EHIu8tDr
 0lVerYXvNltDHbTZ6zbhuhyGW2KqWvsXMJb01yKJb9iveXea+wg7+RXDrCW1D5lMEzBbVPn2px2
 omjn7GM4cp2yw9yqlnW7v9/GrhnKdJa40vqrMPHZzmqE6n5hBIkd4YnEMTbgq7iP7gem0+p0CsT
 tBybBuXlanUtXwrySlHjQCz/T9o6XQxcep5fHMiZ9zBKaeXEKgwtgpcob4QpVnguWhS6FXnHuV2
 hd1qRwmU6cotp3HZaOr2vpDCxEunMcmchLfVygd5NgRu69E0gmAQt2Cmh4M7muH2UTFJaGnyNK8
 ACO2UWGrc5vaqIXKOUonWMM8mRaveolnaDsFnA++kpnVjy6l/f3Ue6cTRtwlYN2gHvIcLSbUW5J
 GaqgFuDlJhzRmH9z2Hzvzj8Qmh2mIT8cumbUUbVgi3E8kbVdFYggYf8zCK1S0I/TFG6/RToKKbV
 oytcpUCB3f7Qt3CWByA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160091
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8266-lists,linux-pwm=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B4FCE298FFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgTWFyY2ggMTQsIDIwMjYg
MTE6NDIgQU0NCj4gVG86IFNhYmF1LCBSYWR1IGJvZ2RhbiA8UmFkdS5TYWJhdUBhbmFsb2cuY29t
Pg0KPiBDYzogTGFycy1QZXRlciBDbGF1c2VuIDxsYXJzQG1ldGFmb28uZGU+OyBIZW5uZXJpY2gs
IE1pY2hhZWwNCj4gPE1pY2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+OyBKb25hdGhhbiBDYW1l
cm9uIDxqaWMyM0BrZXJuZWwub3JnPjsNCj4gRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGli
cmUuY29tPjsgU2EsIE51bm8gPE51bm8uU2FAYW5hbG9nLmNvbT47DQo+IEFuZHkgU2hldmNoZW5r
byA8YW5keUBrZXJuZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47DQo+IEty
enlzenRvZiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERvb2xleQ0KPiA8
Y29ub3IrZHRAa2VybmVsLm9yZz47IFV3ZSBLbGVpbmUtS8O2bmlnIDx1a2xlaW5la0BrZXJuZWwu
b3JnPjsgTGlhbQ0KPiBHaXJkd29vZCA8bGdpcmR3b29kQGdtYWlsLmNvbT47IE1hcmsgQnJvd24g
PGJyb29uaWVAa2VybmVsLm9yZz47IExpbnVzDQo+IFdhbGxlaWogPGxpbnVzd0BrZXJuZWwub3Jn
PjsgQmFydG9zeiBHb2xhc3pld3NraSA8YnJnbEBrZXJuZWwub3JnPjsgUGhpbGlwcA0KPiBaYWJl
bCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT47IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7DQo+
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC0NCj4gcHdtQHZnZXIua2VybmVsLm9yZzsgbGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzRdIGR0LWJpbmRpbmdzOiBpaW86IGFkYzog
YWRkIGJpbmRpbmdzIGZvciBBRDQ2OTENCj4gZmFtaWx5DQo+IA0KPiBbRXh0ZXJuYWxdDQo+IA0K
PiBPbiBGcmksIE1hciAxMywgMjAyNiBhdCAxMjowNzoyNVBNICswMjAwLCBSYWR1IFNhYmF1IHdy
b3RlOg0KPiA+IEFkZCBEVCBiaW5kaW5ncyBmb3IgdGhlIEFuYWxvZyBEZXZpY2VzIEFENDY5MSBm
YW1pbHkgb2YgbXVsdGljaGFubmVsDQo+ID4gU0FSIEFEQ3MgKEFENDY5MSwgQUQ0NjkyLCBBRDQ2
OTMsIEFENDY5NCkuDQo+IA0KPiBzdWJqZWN0LCB5b3UgZGlkIG5vdCBpbXBsZW1lbnQgZW50aXJl
IGZlZWRiYWNrLiBSZXNwb25kIHRvIGFsbCB0aGUNCj4gY29tbWVudHMgYW5kIGltcGxlbWVudCB0
aGVtLg0KPiANCj4gSSBmaW5pc2ggdGhlIHJldmlldyBoZXJlLg0KPiANCg0KSSBzZWUgd2hhdCB5
b3UgbWVhbiBub3csIHNvcnJ5IGZvciB0aGUgY29uZnVzaW9uIG9uIG15IGVuZC4NCkkgd2lsbCBp
bXBsZW1lbnQgdGhlIHN1YmplY3QgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KQmVzdCBSZWdhcmRz
LA0KUmFkdQ0KDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==


Return-Path: <linux-pwm+bounces-8968-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGhfNU8sC2opEQUAu9opvQ
	(envelope-from <linux-pwm+bounces-8968-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:12:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D98956FABC
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B916B3006966
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 15:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783ED351C04;
	Mon, 18 May 2026 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qnqP84uz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EAB315D43;
	Mon, 18 May 2026 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779116758; cv=fail; b=WK1KCplaBGcopjzZcMs6PF8Q2BJTQ9wel0npBmstGhPt7TtRkf5iNUDPT/T4LXtvlyq2cmokOpcjLBmzf/buBxXNnC7z5Axxf/3TiS1Ws2sWpQWGUgzbTuZqfhtOJhS4fIqUX6gpPD/vTZ4+GhrQxjcl0C6CZbJIRpuHL0mEHYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779116758; c=relaxed/simple;
	bh=CEIM1fAWCzdtQ9dCxE2ic3MjOyPMjkplf3/CfN8k5rg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PXcYP97L7Vd1eGwQlI1MFS9Mzlbz60ZH3N8OYUzMLPio6m5EgbZT5bbW4VZ3g3dDImsdzhf9e68c+9RKH2NeuSNLPQg+pYort+EH9JwX81PMbHn/HXm1G40X3+ebCO3SpOZSUz+NI6W1FZtjqtQCgMbCU5BntAEAmmGVhoVAdG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qnqP84uz; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I9gIiX3481925;
	Mon, 18 May 2026 11:05:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CEIM1
	fAWCzdtQ9dCxE2ic3MjOyPMjkplf3/CfN8k5rg=; b=qnqP84uzGv2qK/NzTxGro
	hXbnwkGS3uLruYiQZILDsomxrJ/QejCAZF5zXta9mtXB/zNw5ia82tMgZ/dDMYCW
	X6j6QhZ/vFmsKSlVZGkrRpdz+o1AE6P/iLZ+RUnDoYEVj6fr2LL7xkcfTEJ8grvp
	YTR89pTZ6sk0G3gsKiA25pifAbdwMwAp0LUQoAg8AO1foHpPnfD0/irr0FQA/ubx
	3kA+RlIx/Eky8hrkprfj9ZEFleOi+hMTGKMBp0SpcIZCuGr0oie79QRauqPic7ax
	UIw9sD6nywjvexuTamW58MPbuWOdzt2u1Yk4Mw9dCxP7xXDyJK67o0PPKMy4wpNF
	A==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e6jdxpwkw-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 11:05:38 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jf6TAeACf+GQnxrkNgI0M9pE1T322m9yhQV67CzAHku9L8G8brnShKZAY3SycB97jN+CpsrBLubcKj3n9rEmaU6c800ZkBmVRr6lAEdEpfeXC9ti0hdbTd0Zsh5fYq6ULi+TSSTofQ8SF0Qb4TTzmtjxN/kwTcofXRGtRDc+4HryPol7Wx5JAZy+WXReR/bONfAAZ8a56O6L8x6rJjmTzV8vjA1xUocWdkZM2pI2ZZc6kqIb52VQP50o3sDems6rU30KZk5p1wnf6Fd/zHdjxRzWvHmXvYozMTlot+FL/M2ze6qVn8MdpmUzvUcEwwYqAKGJWnOiY/W/aHCw6FxO2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEIM1fAWCzdtQ9dCxE2ic3MjOyPMjkplf3/CfN8k5rg=;
 b=qjPdg8ekNlqpC4vDKQo1LuaCWPCWzwrjLV0rvF1NktMQDnbZY+4OyxND1W+/ghFGGKYkOytdzOCqRZJGSc/iXYf5CZH6lEtECvguMjwH+QC86af28JftYnx5AUWe5soJ8OekK5wPEut1W77MLOmjNNsJfI9KJ/p0+8T9Bgk9Jl1PaHXmIUpdJS6CIXD+nch3F1vC6BOtYPjubqMVYW6+hKujZKFFekf1tfm+OAfYHBGS6Khc08I7M0w3hgqhlN7oz0P19mzqEn+NjcHyK3QQPKUyoAwWgqvbvaZVtqVgcYFyOcSad1n50KU7mkokmAQ/JY21oNHWC+DSH90ajI6YoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by MW4PR03MB6540.namprd03.prod.outlook.com (2603:10b6:303:127::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 15:05:30 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.21.0025.023; Mon, 18 May 2026
 15:05:29 +0000
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
Subject: RE: [PATCH v11 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Topic: [PATCH v11 2/6] iio: adc: ad4691: add initial driver for AD4691
 family
Thread-Index: AQHc5G8oCth+klOl+E2cQcQun6UuM7YSHnaAgAHG0JA=
Date: Mon, 18 May 2026 15:05:29 +0000
Message-ID:
 <LV9PR03MB84142E635BABADF329061A7BF7032@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
	<20260515-ad4692-multichannel-sar-adc-driver-v11-2-eab27d852ac2@analog.com>
 <20260517125241.7dbfb964@jic23-huawei>
In-Reply-To: <20260517125241.7dbfb964@jic23-huawei>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|MW4PR03MB6540:EE_
x-ms-office365-filtering-correlation-id: da8f40c7-71e0-44fb-4065-08deb4eee6a8
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|18002099003|56012099003|4143699003|3023799003|11063799003;
x-microsoft-antispam-message-info:
 /izRNAT7PZr+qPb1texJj7iZ7GXqXVHnNHbt6UIy5Xs0w2h9V9NoERjT8BEkrpQhajiioDjLrvEYzkklSdqKebfPlvHcjldlp28QONseI7raJE/14qFQ94Qjf0VkJ+9a1WJV+RnNo1yCfcbZpc0axwjWlHCR0aYIOwrib6zQNgeXIpCY0hGcQyqZ/a8QzidLzb6Jk1fI4i9vJrNyavqiGSeAPRpOTLjrvpRyM9z6f4ZN7RMai6ZnQByFjTtQIDQugjkmZ+G+lgnICKdfPWCskVbe33NLYfiVimJ0nIG7pxqjSzHb68k0gYpvhv19Er6ZhJj475vjaFKKMwGQ/Y81/9KVObyFfzqlCSDsQxYnke+waLchpUK3BWufB9pAcciHMENaq8mYFh6tXUf/bb9FORQi6rCLqRBSNCKEXaJTo6WCj4+k9o7IFhtAoN3XkA1Ta1lgE8eVCPETArxKAXiTivpLGi0IVnUo5FgxN0qEf0x9dbTGAjOLV02sg0DgchbKVzqoGYdQIGMV8CYgkJntMTqcWume0LY+XLNlkEoBmE1Sm55k7kAROnhrnWUnqDlNR1UQmc2DXuCWAQ/GeV5oi1INe1qXhqecydiYI7RmEeY4wMJhZXeGUuQnaV1/BjPJ6csSI5WswwSlFDByfYuVdLLXID3akEP7ZLVo6TSUX2fUfp54vaKsadF0AAv8KV08
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(18002099003)(56012099003)(4143699003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MTBKRVZRMmtRT29EcStWL1FXMVd0eC9pVmVQZ2duQVhCd003RitaZXBONGZk?=
 =?utf-8?B?Nko4U1QyOGlsbCtKUDdvRGU0ellVU1lhanZaOWROMzI0K21BTHRsY2o2Mlh2?=
 =?utf-8?B?a3V0REk1WUtFdE9IbEY5N0VrNCtQWFBuY0pZVVpDQlBKSi9CdFN0dkJxaGpn?=
 =?utf-8?B?Zjc4dG1oOFA5RkFOT1BIU3hzUnZDOFQzV2UzMXY2ZE9aWG9scjRBamlDa3NN?=
 =?utf-8?B?OXRkVTNvRU1vR3VXVXErd095UzByamM0c2xlN040UElVYTRld0ZvOWtqZ0Nr?=
 =?utf-8?B?cjZpZ1A1citDVVFUUHc2YW05OVc0TFI0dGlxUTkzcTgybmZjMGtoVDA3SmxO?=
 =?utf-8?B?MzZDQ1g0RVZkK0FIU2RoVkR0WjVyb04xRnk3TGZFV1RETXVEQjJsSFpQRVdE?=
 =?utf-8?B?N2hDL3dGdTF5S3ZEc0hzTmx0RkVOMHVMYlIvM0IrU21FenNHRUU2MVNVbW5E?=
 =?utf-8?B?YlFYazYvSHBzQjNlMDJPdGFEMnJWdER1cXE5dXZHdTNtV01hWW91QXkxYWhF?=
 =?utf-8?B?R0xEMGp2cFN4OHJrVUVNVUZIQ0RhV09UcFhWSlhpN0ZOQTFEeXB5ZWlVQ0w0?=
 =?utf-8?B?MWZiVVdQZjJ4eDJ5NXQxQVpyWkdvVFBJOVNnT3pnQ2t5MEsyVnc2c1c3SXZP?=
 =?utf-8?B?UlJMby9RbGk2NkNwdGJSaVVzd2dQTmlrbFNJQzUzR1VqU2IrZlNTN3BQVzNl?=
 =?utf-8?B?c1RnZXVteDFwK1NCZFdvdDlybmRWUDFReUhZaHNGUG9tRG1USmRoOHdVRTRT?=
 =?utf-8?B?MFZwbTRvYXFQVWRYMWxneFV0MDdhdWFlT2Zmc2NpQTAwRjF0RGFZSElkdU9D?=
 =?utf-8?B?S1M4ajhjSlVOWkhhNTFWbEM3c3NCeS9VZm9lWnE4YnkzaVFVT3VPTGpUMGZx?=
 =?utf-8?B?YXltNVR1RVJuT1ZOckYwUmVjVHZkbFdobGlvenF6YnpyaE4relZuZE1VMFZL?=
 =?utf-8?B?eCtWa1NsWXh1QzdDa2V1L2szcWRmVUJWQ2hiS0h2c0VjZytuVzZYV3Ntek9s?=
 =?utf-8?B?YjIrUUpqOEE5VXRiSFBhS0MxbERuZUx4bnpBMFNXOFlZRDZVR3ZxU25rRGpx?=
 =?utf-8?B?QzhCOXplNGZqT2JGK1BxWjNOeG5EQ2taelhuQWlmL2dYalM5Qk5idzUySmRp?=
 =?utf-8?B?dkVhVExOeDZuOGRKQ1dQbnNSVm04NDZGM1dXU3Q4MXlvOWdzQ1dTL0x1Q0Rm?=
 =?utf-8?B?RFBOOGhBOHVFUTh3QVRxTy9DL3Z0bkJHTVIyRG1QSEcrM0czVDJSQVNkY0ZV?=
 =?utf-8?B?Vmk1ZWxwQ0pnRFRvU3VydC85ZTEyaXhHWHpVQ0ZBbW1KY3FibTByNlF3cTNw?=
 =?utf-8?B?N0hhTkRYdEhyN0pkSE9iTUgwSTlvVVVSdEMraXZkOHFPZ2VYb1FzNDJ1YWNt?=
 =?utf-8?B?ZXVMRWZBVWlzSUo4NGp4cENJbkwvZXpRU0QzQTU1Z2J6SE1NdjRLZ1NxRjBl?=
 =?utf-8?B?SHZKeXlFUEpYeHVnc1BHOUQvRWNkY2FqR0lWNkg2MmJPMUt2eHFRMXUyaE10?=
 =?utf-8?B?VFpMbmlhK2dxTVRzUlMyRTk3NCtDdVJsNUtnOFNGQjhhWThicnQ4Wm5PTk1s?=
 =?utf-8?B?ZzU4aURVTHlhb3NmRmlNMWJmSXlkZStyK25yQUNwQ2U0SWRPeG95ZXljdW9C?=
 =?utf-8?B?SFY3SEsxSGtCZGc0Y0FadEthUVBlVVViSEVLWFlxa0ZXRkZ5SXVDYmFHdW9q?=
 =?utf-8?B?YndQMEpOc1o4WG1xNXdKRHFSTjFyeGRrRFZlM1dzc0d5RnlIcnFoQlVIMEcy?=
 =?utf-8?B?bytxaG1yYnZOTEUveFFtaEF3K2NoTG1ndGtpaVltT1NkZExJMWtWMm9mbTN3?=
 =?utf-8?B?TFBBWUVDRTFzUSt5WHVOaFYzMVViNWV5VlFKOTdQNTI4Q1NBaTdPWFArTVNN?=
 =?utf-8?B?alZzcEFvaG05eEFlTU0ya0tKNmtaUTZyRkZqaVFpLzI1U2hBTWZnYXRSV0ds?=
 =?utf-8?B?eFQ3Q0xZQkhhR242cFovMCsyWUZDaGU0MFBEVVliYWpkSGhraDRwek51aXkz?=
 =?utf-8?B?OHRkTTJLdXc4YmFTYitPaFRqRzFNNVQwTkltZHY0UmJITW5PY1FyTE5USmVk?=
 =?utf-8?B?Tk5NeDF2STN4bDMvNkNqdEhTeWpvamM3U3J0UHJkbUc5Vkp2UzNlOGorb1Jv?=
 =?utf-8?B?T2xCQ014Tm1FRDQ3TU5XS1NFNUJkYVBuVHJCQkQ4YXE4WlpLWVNtRlVaTzdz?=
 =?utf-8?B?UHozanJqcW1ZZkNDRFAyeEhuUE5pOTUrRXB6VEQwUGM5cFhkNm1Va3lzVDls?=
 =?utf-8?B?QURNZ2h1emI2WDFJdVg5a3lpMitlblRZNHc3bGduL3NEUHBYdEZkWUFvQURU?=
 =?utf-8?Q?RvRN7caFs7nsxJxOZ6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	L8AiQRa4qQbI14nBvXEIrYxs9vadUrjfvep9GB9Su55X1sCqI4mSlogvvBQywOgr+pemJabw+t/0J/LFSxXE1O0Th4ahKxLULYZkq4CGergh951Jl31LV4A1DfKG2Hn8BfXwkzsRcegpNBADa+rHDsMBb4PSKj051HTA9wIU0LzFldenbmXHFw5/Vn0cAOolC3sT2FVBSVSAC9CAFWAbL5Oy7hDJvyekU8sRv1BeJETNiB/TlCdeMve4Siy/utEMlcrcS2Z7t6kR3JC0GSlMSaIJFOeBGFkiNpmhx0jiS9eIdQ5bVDhbpzmd0SDzYrmCwmBUAhav/4mr8rtwiU6e8Q==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8f40c7-71e0-44fb-4065-08deb4eee6a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 15:05:29.8147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOQT8LSgd99Bp31y1bgn1+n1Z5wSugV0kzBNJE0oa2x996KIAM36Vg/PqsDPWnLVtzJtJLqkHWqaw89wMALgmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6540
X-Proofpoint-GUID: 3RsoEGNNJiUdpRdtSvFfjuUUoDz6iLnd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE0OCBTYWx0ZWRfXw3eu9WhDtGe2
 Rmmw203YfkKrS9oWZ643PnIqrVKnLI6afekgbWP+HfO6g5R9uQGNioJXga6SkPrWW62T1A9fi/B
 6oCQfaujFWnNNkt7sr4wGTGZ+yxZPjyGoP+dVKDp2j63tsA7PhHZLiD5pdUH2xyMOJPY4KS2a1c
 OiGAhA5m/A0MuesuUXrqqzdHtxYB0s+g6RgM6oGXUeTurNdYj9P7GRcY+d/c3N5oo8SpRXtd7hX
 iUGEPweVTWln6oVSnxnD9TG9DY1hkTttGjS0bBGUGPsnyL/QK/KaENeH/YpXh3JkQQ0bjON8vgn
 u1aIytqcjEhFbmUCV6bpFrLYsmF+XpJSiam3fdnj4AHtiRvPWzPMTirXmj3b7Cht4nMaAXade8n
 NatTkWrVzmeaTd/PJDWNNTSrxIp0zCqJ2l9Yo3u4n+eTnaRVQ7SWxHZ6/E5N7JjjMXibKtYA8U7
 GRhl5CubWDdqSQGIIZQ==
X-Proofpoint-ORIG-GUID: 3RsoEGNNJiUdpRdtSvFfjuUUoDz6iLnd
X-Authority-Analysis: v=2.4 cv=FfwHAp+6 c=1 sm=1 tr=0 ts=6a0b2ac2 cx=c_pps
 a=zLPr+aUDpHWP/LWwllnpHg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=uherdBYGAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8
 a=aoylWq190s6Ob73TCPkA:9 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180148
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8968-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[urldefense.com];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3D98956FABC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBTdW5kYXksIE1heSAxNywgMjAyNiAyOjUzIFBNDQoN
Ci4uLg0KDQo+ID4gK3N0YXRpYyBpbnQgYWQ0NjkxX3Jlc2V0KHN0cnVjdCBhZDQ2OTFfc3RhdGUg
KnN0KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSByZWdtYXBfZ2V0X2Rldmlj
ZShzdC0+cmVnbWFwKTsNCj4gPiArCXN0cnVjdCByZXNldF9jb250cm9sICpyc3Q7DQo+ID4gKw0K
PiA+ICsJcnN0ID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9leGNsdXNpdmUoZGV2
LCBOVUxMKTsNCj4gPiArCWlmIChJU19FUlIocnN0KSkNCj4gPiArCQlyZXR1cm4gZGV2X2Vycl9w
cm9iZShkZXYsIFBUUl9FUlIocnN0KSwgIkZhaWxlZCB0byBnZXQNCj4gcmVzZXRcbiIpOw0KPiA+
ICsNCj4gPiArCWlmIChyc3QpIHsNCj4gPiArCQkvKg0KPiA+ICsJCSAqIEFzc2VydCB0aGUgcmVz
ZXQgbGluZSBiZWZvcmUgc2xlZXBpbmcgdG8gZ3VhcmFudGVlIGEgcHJvcGVyDQo+ID4gKwkJICog
cmVzZXQgcHVsc2Ugb24gZXZlcnkgcHJvYmUsIGluY2x1ZGluZyBkcml2ZXIgcmVsb2FkcyB3aGVy
ZQ0KPiA+ICsJCSAqIHRoZSBsaW5lIG1heSBhbHJlYWR5IGJlIGRlYXNzZXJ0ZWQgKHJlc2V0X2Nv
bnRyb2xfcHV0KCkNCj4gZG9lcw0KPiA+ICsJCSAqIG5vdCByZS1hc3NlcnQgb24gcmVsZWFzZSku
DQo+ID4gKwkJICogZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9leGNsdXNpdmVfZGVh
c3NlcnRlZCgpDQo+IGNhbm5vdA0KPiA+ICsJCSAqIGJlIHVzZWQgYmVjYXVzZSBpdCBkZWFzc2Vy
dHMgaW1tZWRpYXRlbHkgd2l0aG91dCBkZWxheTsgdGhlDQo+ID4gKwkJICogZGF0YXNoZWV0IChU
YWJsZSA1KSByZXF1aXJlcyBhIOKJpTMwMCDCtXMgcmVzZXQgcHVsc2Ugd2lkdGgNCj4gPiArCQkg
KiBiZWZvcmUgZGVhc3NlcnRpb24uDQo+ID4gKwkJICovDQo+ID4gKwkJcmVzZXRfY29udHJvbF9h
c3NlcnQocnN0KTsNCj4gPiArCQlmc2xlZXAoMzAwKTsNCj4gPiArCQlyZXR1cm4gcmVzZXRfY29u
dHJvbF9kZWFzc2VydChyc3QpOw0KPiBTYXNoaWtvIG1ha2VzIHRoZSByZWFzb25hYmxlIHBvaW50
IHRoYXQgd2UnZCBraW5kIG9mIGV4cGVjdCBzb21lIHRpbWUNCj4gYmV0d2Vlbg0KPiB0aGF0IHBp
biBkcm9wcGluZyB0aGUgZGV2aWNlIG91dCBvZiByZXNldCBhbmQgaXQgYmVpbmcgYWJsZSB0byBy
ZXNwb25kLiAgSWYgaXQNCj4gcmVhbGx5IGlzIHRoYXQgcXVpY2sgLSB0aGVuIGFkZCBhIGNvbW1l
bnQuDQo+IA0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9zYXNoaWtvLmRl
di8qL3BhdGNoc2V0LzIwMjYwNTE1LQ0KPiBhZDQ2OTItbXVsdGljaGFubmVsLXNhci1hZGMtZHJp
dmVyLXYxMS0wLQ0KPiBlYWIyN2Q4NTJhYzIqNDBhbmFsb2cuY29tX187SXlVISFBM05pOENTMHky
WSE1STVyWEc1VVM0VEZJWl9jQWJnY3kNCj4gZ0gtX0NidDZ3TERaNWpWZUJpUFNEZzVLdXpFWlQt
Q01ONFozYUZZWVZYSDZLeDRmMkNsSmNicjl3JA0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCS8qIE5v
IGhhcmR3YXJlIHJlc2V0IGF2YWlsYWJsZSwgZmFsbCBiYWNrIHRvIHNvZnR3YXJlIHJlc2V0LiAq
Lw0KPiA+ICsJcmV0dXJuIHJlZ21hcF93cml0ZShzdC0+cmVnbWFwLCBBRDQ2OTFfU1BJX0NPTkZJ
R19BX1JFRywNCj4gPiArCQkJICAgIEFENDY5MV9TV19SRVNFVCk7DQo+IFNhbWUgYXBwbGllcyBo
ZXJlLg0KPiANCg0KSGUgaXMgcmlnaHQuIEFuZCBhbHNvIEkgdGhpbmsgSSBtaXNyZWFkIHRoZSBk
YXRhc2hlZXQsIHRoZSAzMDB1cyBzaG91bGQgaGFwcGVuDQphZnRlciBkZWFzc2VydGlvbiBhbmQg
YWN0dWFsIFJFU0VUTCB0aW1lIGlzIDEwbnMgbWluaW11bSB3aGljaCB3b3VsZCBiZQ0KY292ZXJl
ZCBieSB0aGUgb3ZlcmhlYWQgaXRzZWxmLg0KDQpJIHRoaW5rIHRoZSByZWFzb24gdG8gd2h5IHRo
aXMgd2FzIG5ldmVyIGEgcHJvYmxlbSB3aGlsZSB0ZXN0aW5nIGlzIGJlY2F1c2UNCjMwMHVzIGlz
IHRoZSByZWNvbW1lbmRlZCB0aW1lIGFuZCB0aGUgbWluaW11bSBvbmUgY291bGQgYmUgbXVjaCBs
b3dlcg0KdGhhbiB0aGlzLCBzbyBzdWNjZXNzZnVsIHByb2JlIHdhcyBub3RoaW5nIGJ1dCBsdWNr
IG9uIG15IGVuZC4NCg0KSSB3aWxsIG1ha2Ugc3VyZSB0byB1cGRhdGUgdGhlIGZ1bmN0aW9uIGFj
Y29yZGluZ2x5Lg0K


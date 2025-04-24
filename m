Return-Path: <linux-pwm+bounces-5682-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2C0A9A09A
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 07:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD003A6FA3
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 05:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0DC3FE7;
	Thu, 24 Apr 2025 05:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="FfACjeqb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010022.outbound.protection.outlook.com [52.101.228.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2544523CE;
	Thu, 24 Apr 2025 05:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745473541; cv=fail; b=Oa/IF2EzKMwSoxOyWYhFpYAv2WJn/TpmmcVOkAKwqsAwnyW/YQUXlw415wcv/T4IG7TQYlKbN639HcvOAjqpB9hd3zJhLyFLND3NbwkuyCBNjoVuJoYITlQIbHDMBxzqdYXE8dSQFGCaMtSERhQzsMnDnhwkJ1t0dcLg4ApqgGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745473541; c=relaxed/simple;
	bh=+3jgdmFQghKLrc76lY4qXh2kEFePoXP8cBwYbea5cZI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BOAbeaiNhkwWYcNurEi1D+CaseXH2KRwiqpGDPWr0rcLr8MU6r+vizFXdLXplo/nESGPNIx/tyTSZnjX+VJESHDr7aPYB5fsv/HER0KBBmqGdNj2swQHC3n8gPnbCyQR5RDr1UmBd0ZGPhqbPfaUGU6FV1tCtisHi6149k4OH1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=FfACjeqb; arc=fail smtp.client-ip=52.101.228.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPRjE8hrXVHha6yBJurdI7rQcQBBHRsM3c06NSlTjiG9bd9Va5fyAdTqDtnaGH1dGbxDZpUFNDohdYjcrsG8GEZN9bY3Yr/s/Mr4hWf52OmgcEhID///rNFdPK9Dlgh89dumiopHlvkzJV9aJrLKfM/zru3QAdZScyK52P1zhE0EUjJ3Z7JjETkyqcd3IKxNd2gG0P5DYnF0qstZkpoYefpKhd721evCeVtnEAAI9yv3ricRVnf92nImpY7oem4Zzryu2wt2BAPA2f0yRpw0t6YhBHpScTrTnbwqY7P/kYrHOEqvsadfL5wMSto8SUZ5rXszxHJDgHrW2vXyYVwcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3jgdmFQghKLrc76lY4qXh2kEFePoXP8cBwYbea5cZI=;
 b=n1xEtCxC0WaQMzF/x5mRI7UEZ3ys1mHvObn/XgKXtw0kGBG/mD3b3u1PYZrA3/NithCSh+dpCEBUbY9iuEw3KsYa5h9ORQwZGNwH+x0gEJnn1U4i+nS6jkgg0SSUzlTcqdRMxi7bLHcTwa91Lj3OeS4Jk3N32Gex0WxZ+Cbb/ZkkSb4zyPfjvDh/ypJnPD06q8He7nurgk7Ss2BJx3T0S1mJP61jFbEZJ2fZ+rfQuXzFfTIfnBBBUhMZlh5me2YS+p02LwRQawg98HGy0eGwAIIAZkcl3Yq/Np2DdntXe0I4T0ruu9IaCKTj5mCnnuC/Y5SijwARDUAWLcvAqfma2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3jgdmFQghKLrc76lY4qXh2kEFePoXP8cBwYbea5cZI=;
 b=FfACjeqbdejpHh2T8/s6h6SNnBKQePJYVSjzZ7toLp1SATZ00UV/Va6OpAOxNzAfh3nRexmsrZBAlYvv29b61K8FBgrNR/MlyUj86BnjmCrAMGAbxWO9V43Gj8t+CDNsgQE/9wNwUTvR+R8yESLd09HCfip7gDwqzWxMLB7ha5c=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYAPR01MB5532.jpnprd01.prod.outlook.com (2603:1096:404:8040::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 05:45:32 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 05:45:32 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] pwm: rzg2l-gpt: Accept requests for too high period
 length
Thread-Topic: [PATCH] pwm: rzg2l-gpt: Accept requests for too high period
 length
Thread-Index: AQHbtDYj0E/KcMJm6UqRz5YguTnDJrOyTs/A
Date: Thu, 24 Apr 2025 05:45:32 +0000
Message-ID:
 <TY3PR01MB11346A3CC284B74692130149686852@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250423095715.2952692-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20250423095715.2952692-2-u.kleine-koenig@baylibre.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYAPR01MB5532:EE_
x-ms-office365-filtering-correlation-id: 4c4d0e2d-9f23-408e-6133-08dd82f33a48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?REJQcmdORG5yVktPRG84czFwK2p1YytNb1ZGWldMbnJtQW85UVpCcStLckNC?=
 =?utf-8?B?ZHRqNGM0OEZzMUFUbGJITWlpT2ZJcjhkR0dqYmg4VHl6YUwzYXZjOUd4blpr?=
 =?utf-8?B?K001cGdZK1BNakRidDZBazR1V3JsRmFLU1oyL0lBTUNUNlpYOGRZS0U2SkJj?=
 =?utf-8?B?bm43ejhpRWtIaGdDT215RjY4cEl5dXFseS9Sd1E0U2VMdm8wNUo1QU1lNG1y?=
 =?utf-8?B?RGszQUFQdkt0WU5PWGdPczdZNW95ekZBNlZhenV4MmZhOEhPZFZmeHVSbUNP?=
 =?utf-8?B?MnQzWnRIWnNlbk14bTE5MGdkejdaWmJ4VUlNNUNKOU00cFd3TU1xcUprU25w?=
 =?utf-8?B?ZExReng2MWpZRndPTWh0dFhBUHZvajNiTGhCdTNXZ1IzRmJWS01La0VhY015?=
 =?utf-8?B?V3I2ZENFWGhZbk8yUU1QbUNnZVdIQXRCRDY4N2h2MndVVlZZRGFwQ1NSOGc3?=
 =?utf-8?B?STVBZEVJaDhlZGhZVUFhT3FjVzUwQlR3TFBXS2FLMHFyWHhWL3FpQ2xZdFZw?=
 =?utf-8?B?TU45TnJ0TmZrRVdSR1ZHTFZRQ0UwbHNjVm8wNVZnaWc1T3hWamhOZjdTL3o0?=
 =?utf-8?B?RmtEZUpDSU43WnpCTXY2YmpJOEIyQmoySmU4VkpsYXlBV0V4Y0hkNmNaSjRL?=
 =?utf-8?B?L1FCOXNYZUM1QnJqKzVyVzROT3JiN1JORlQzQXluU1lxMkJhdEF1dGtIUjFY?=
 =?utf-8?B?OUdUOXVab25meFZxUTFXbVBXQWQyUWY4ejI3TXRXVzFpUDJ3b1lDdFRGdXI4?=
 =?utf-8?B?Y0xTTVV6Nmc4TUpNcUZtTWZ4ZkQvUXBZVk5WanlSSmZBblE1RnBxOTArMWJa?=
 =?utf-8?B?QXNHTW9yMXRoY0pNQ3FYcG1GNVBzcnk5eVExN1dUeDJhNmRSbEg1L29FOVJ2?=
 =?utf-8?B?Q1BZM3VmTW5HVjFZTVk3c2k4RnlIQVRvMjEwbFYzcGEvTTByWWV4Wi80QzE0?=
 =?utf-8?B?c0dvckorM0Y5TTA2cHE4RmhsY1JPdk1KRkJaUnJNMFNobHFVWXhYcm1VOUhn?=
 =?utf-8?B?WlB5MzVhL2RMUnczV3djTTdKRE0xcHNpUXJtME1jMU5zenFlb05sd0tGQ2tn?=
 =?utf-8?B?OGJkMG1hcE53TENmNE16RjRsYmlaK3I0b2ZjbWV4c1JmTmgyQmtnWng3QVQ4?=
 =?utf-8?B?V2IyMXlJbzVEMzNROW5YU3NwV1FTQi9ZV1J5ZE15SDdCcmRrMjBkVFJVaHVr?=
 =?utf-8?B?WnY3b3RHaWt0MmM4YjN2YXZQN0t6dm43UWljNlB5ZXpXYU9HOEM2dWRJeWE3?=
 =?utf-8?B?eWdYZFhiU2YrcENXNVhSTSsrZksvdm84TVQ5YVMvdWJ2bTBrZ212OVRUVXBG?=
 =?utf-8?B?S1VMdmhwUnRXUU9DYzhNRm5ESnBVRmlPRlNhWlVBaURMeEZML1VyRUZZTW9l?=
 =?utf-8?B?SUw1NlRBYW9UMkxnMmlJb0twc3pOemN6SFp0SThlbkJPdzIrL1ZDanBvUHNn?=
 =?utf-8?B?RnljL0c3YWsvZ3EwVDQvdUsxNFBEQWRTckFUM204aWE2bFg3b2xoQ3cxbTV4?=
 =?utf-8?B?NkZxKzVoOGd5YzhpTmQxK0hTN3JXWDkyTVhMZDhVNUpXY2d2Qmk3WEZTMkRi?=
 =?utf-8?B?TDlsTDJDYnEyem1YeDk5WnpEUjA4RzRTYXF6dSttdnk4N3QrMGpnMFJDbjZu?=
 =?utf-8?B?RHlacXF2UitFQ0RzOWtmVVdscjk1OFAxdHNucDlHa0NodGFkb0RaeWtJMEJ6?=
 =?utf-8?B?Z3M2VFVmNG1ZUGl0cnc5V29VUUV4YjkwbTB4NGtzMDV0V3lFM2ZxQ3pON2wr?=
 =?utf-8?B?Z1ZWMWZmZXZ5dFZhK2pMM2VzRTlhdzNFMUVHeUQ1ZWJ4U2JhVkZlbHNSbGRD?=
 =?utf-8?B?UkJZb05CMWJoY3pKTlJvV0RIeWRCMmhTL0UxS3k4NmhkOFYrN0kyRFQzWjNu?=
 =?utf-8?B?c3hzNlVzek0ySE5PMVdEY05nK3ZsNi9qRzJEdHhRaVZCdVB0dVdPTnVoV3Vl?=
 =?utf-8?B?TjZsY3p0bW8yR25iclQrUFVGeVRIKzhPcFA3M2xMNVdMUGJRQzQ3MWhocVQ2?=
 =?utf-8?Q?y3uP7H96oiR58MDS5F/y/e7nm4wMa4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGE2ejA2K0hZTUhFc0dHU0FHQ3hXSTZjOHMyanJ0S2FOdkMrOXZHMWdVWVdH?=
 =?utf-8?B?MEtCMDhKZXdudk55QXVnS2xZWHNJbzg4VXN4UmpBOGt1NHJWbW5ydEJzVUly?=
 =?utf-8?B?Y3hyMkh2b2d3OFNpNVd3TExqOWllWXdPcjlHZ3pOSDdzdjMzTmFmanJ2cmhJ?=
 =?utf-8?B?MzhwY2NSV0t2NmNiaTlvZVpsZFlSQzlKWEFZNjlSNWdSS3V4Zy8wYmI1L0ZX?=
 =?utf-8?B?Q0pWZlBnbEtuSzFpbzdJZGVoOGNkVDdsSEpUSEFZSWtJQzFMSHd5cGxLUHJZ?=
 =?utf-8?B?anQ1TkgwU3EyZER0TUpnM3g5c0RlODlzalRFK1pDNENTT01TVnJHNWE2Tkp5?=
 =?utf-8?B?TTJFeVFiTFhpMW0zdkdHU3BVTWVEUVo2T0huMVNreExIVnB4QjdBUm1mR0VF?=
 =?utf-8?B?QU1pckNpUWZNMWMrYU1WdkpGSmRwRUJ6WUNtUUtDeUVoN2RQNVJCc1QvZDJF?=
 =?utf-8?B?ZDh5M1dFK3ZNM2c5N0FJdmZFNTlLaERveFhlMFRYbldTajh4OHNUOGdrYzBT?=
 =?utf-8?B?WVFDdjFiaWRLNWRtbERrUTVXRDRSd1RVbnEwNGhsaWxKUC9RSFFWbm9WSjJE?=
 =?utf-8?B?akJoRnh5bEpGREdERDljaGVWR2xHTlJHWkNybzRJdE8yMEUzSTZlamIvSXVK?=
 =?utf-8?B?TFdHUjA5NHhIT2ZxaGg3SEowc0E1RURrdk1FeDBOdys2c1dVQmxDZXVLOVBF?=
 =?utf-8?B?MTRDeUtkZkR2TXdIZXd0MlhqdHF2NEJYY2NxNW9sVGFZYzdTU1kzNURMUExz?=
 =?utf-8?B?cVNuZityczR3cE9DaWt3VWMrVTRBaXhyT25aeTdyVXhsa042ZU5LWVpvcm9o?=
 =?utf-8?B?T0s4Z2lydmkwS1hNTFhuMU9pQSs2bWUvQVlvdGFyZjk5dThhREFEZnl1THU3?=
 =?utf-8?B?RFlvcnFDaTVTWDhWRnVYQTBTU0tmdUFDRzl1K05LSGNrNCtwMkQxNkY2RmYw?=
 =?utf-8?B?dGRPOVU4WkdmTWdqU3ZOTVFWdzIwYzNsVDZ5MVpxdTZTcW5kVXR6T0VnR2t6?=
 =?utf-8?B?VU9ndDhLMUJnNGxzQW1DNXdkZFRpdEhFRVVjM2p4VmsrenA1MmpLSGMxWGtu?=
 =?utf-8?B?Y0ZyMUNpNXpvalJYRi9KcFo2ZlNhT1Y1OEVwaldKbUE5ci94YnVCZzQ2cmJS?=
 =?utf-8?B?TGsxYTVEWUl6MnJXT3o3UDBwUHREWXpaKzBkdStOYm01VTQrb2hPOVMwbkpL?=
 =?utf-8?B?T2wxY2lRYVcrRDJpSXUrUE1HS0V5RjRvWmZNSHpOOEVReEpYaE5IT3FVWnB5?=
 =?utf-8?B?ZG0yK3NsNTF6VkYvUFlSVlJ6bTVHQUVHRmtDVmFoZ0NhZ3JuOXB2TGtuTVRR?=
 =?utf-8?B?VEJGcG8wNjh1SER2VTRGQ21CVUFncG1xUUhjV05nUmJSd2lCcFA0NFNQRFdX?=
 =?utf-8?B?RUxyNXlPVERLWEt4dUNWY3BxWmdyd2cvUy9NOGZqNFVET05temxORDBjU3J5?=
 =?utf-8?B?K3R0RDJkanY3aFI3dzlDOTRmMTk5TS9RcktzWjlpT0VoQ0xyaEpQMExEb0Yy?=
 =?utf-8?B?aGRUcG9rZVZteVJuanNkelpOTFZtYkREMVQ4U0liYy9WTzBJTkdIMnBsQno2?=
 =?utf-8?B?aWhUSXdWUHYrNmQ4RXlJbTRMRllWNy9vZEw4WEY1enZJRzFXSmVpekJRZHZn?=
 =?utf-8?B?ZmtyVHVMV1Z5OFVjK1V4VFhSV3MzaTJUMlpPdUgxdGtBRHZ6ZzY3Qzd3N3pZ?=
 =?utf-8?B?UUg3TkEvbzJBVlBFTXM3NVJEbDVJSm1leUlad2ZoWTVTemxrRUpoTTlyL2lu?=
 =?utf-8?B?SWtNTkFTZTBVWEFJbHBRYklsQzdIbmVmckRoYzd4M0loMEdzcUtMd3ZtZGky?=
 =?utf-8?B?N2tMbndUNWI1MllUUkE4VjZJRDAySzNZUzZHZkNRRVE3K0Jnem1QaDBSc1g5?=
 =?utf-8?B?WjZEY0lybE9GaE1PYlNmcDlqV3d2bHJFa0EySnU1RTdLOUl6WU03Y09ZTzVN?=
 =?utf-8?B?T2lLdERPRkRucXpvSEJOTG5wWTN6UGVrczJSYjU4YXZGenhTa1NZVmdvRzdM?=
 =?utf-8?B?MDdWVG9lWDlvRW00MnhDU0daNkpSTGtieXFTUEh2em5hNTNvNlQvN2tDclNG?=
 =?utf-8?B?V3hObWlOVWxCS25nZExiOTdPcHBVRGw4WVBqcWhPRitlRnkxRnQ1ZTcxbXVJ?=
 =?utf-8?B?bDNGcG9lSkh2ZGQwd285OW1uUmhIc3NoYmxPRlZOTWlzNHFRaVFRaWNUVVpZ?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4d0e2d-9f23-408e-6133-08dd82f33a48
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 05:45:32.2339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /owq8FFEjMm5sdsheXtqM62ltXPJjSNbMQq24LfGq0CpcxqutaZRgT4BGu/LETloD9i1LNdy83rtWYD9KKGYExhhZtusWg+ZNs5B+A3A8zQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5532

SGkgVXdlLA0KDQpUaGFua3MgZm9yIHRoZSBwYXRjaC4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQGJheWxp
YnJlLmNvbT4NCj4gU2VudDogMjMgQXByaWwgMjAyNSAxMDo1Nw0KPiBTdWJqZWN0OiBbUEFUQ0hd
IHB3bTogcnpnMmwtZ3B0OiBBY2NlcHQgcmVxdWVzdHMgZm9yIHRvbyBoaWdoIHBlcmlvZCBsZW5n
dGgNCj4gDQo+IFRoZSBwZXJpb2Qgc2V0dGluZyBpcyBzaGFyZWQgZm9yIGVhY2ggcGFpciBvZiBQ
V00gY2hhbm5lbHMuIFNvIGlmIHRoZSB0d2luIGNoYW5uZWwgaXMgaW4gdXNlLCB0aGUNCj4gcGVy
aW9kIG11c3Qgbm90IGJlIGNoYW5nZWQuIEFjY29yZGluZyB0byB0aGUgdXN1YWwgcHJhY3Rpc2Ug
dG8gcGljayB0aGUgbmV4dCBzbWFsbGVyIHBvc3NpYmxlIHBlcmlvZCwNCj4gYWNjZXB0IGEgcmVx
dWVzdCBmb3IgYSBwZXJpb2QgdGhhdCBpcyBiaWdnZXIgdGhhbiB0aGUgdW5jaGFuZ2FibGUgdmFs
dWUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29l
bmlnQGJheWxpYnJlLmNvbT4NCg0KVGVzdGVkLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAu
cmVuZXNhcy5jb20+DQoNCj4gLS0tDQo+IEhlbGxvIEJpanUsDQo+IA0KPiBoZXJlIGNvbWVzIHRo
ZSBwYXRjaCB0aGF0IEkgcHJvbWlzZWQgd2hlbiBJIGFwcGxpZWQgeW91ciBkcml2ZXIgcGF0Y2gu
DQo+IA0KPiBUaGlzIGFsaWducyB0aGUgcGVyaW9kIHNldHRpbmcgdG8gdGhlIHVzdWFsIHByb2Nl
ZHVyZS4gT2J2aW91c2x5IG9ubHkgY29tcGlsZSB0ZXN0ZWQuDQoNCkl0IGlzIHRlc3RlZCB3aXRo
IFsxXQ0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwNDI0MDU0MDUwLjI4
MzEwLTEtYmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20vDQoNCkNoZWVycywNCkJpanUNCg0KPg0K
PiANCj4gIGRyaXZlcnMvcHdtL3B3bS1yemcybC1ncHQuYyB8IDEyICsrKysrKysrLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20tcnpnMmwtZ3B0LmMgYi9kcml2ZXJzL3B3bS9wd20t
cnpnMmwtZ3B0LmMgaW5kZXgNCj4gMmRkYmIxM2Y1MGFhLi4zNjBjOGJmM2IxOTAgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvcHdtL3B3bS1yemcybC1ncHQuYw0KPiArKysgYi9kcml2ZXJzL3B3bS9w
d20tcnpnMmwtZ3B0LmMNCj4gQEAgLTI3MCwxNSArMjcwLDE5IEBAIHN0YXRpYyBpbnQgcnpnMmxf
Z3B0X2NvbmZpZyhzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2aWNlICpwd20s
DQo+ICAJICogcHJlc2NhbGUgYW5kIHBlcmlvZCBjYW4gTk9UIGJlIG1vZGlmaWVkIHdoZW4gdGhl
cmUgYXJlIG11bHRpcGxlIElPcw0KPiAgCSAqIGluIHVzZSB3aXRoIGRpZmZlcmVudCBzZXR0aW5n
cy4NCj4gIAkgKi8NCj4gLQlpZiAocnpnMmxfZ3B0LT5jaGFubmVsX3JlcXVlc3RfY291bnRbY2hd
ID4gMSAmJiBwZXJpb2RfdGlja3MgIT0gcnpnMmxfZ3B0LT5wZXJpb2RfdGlja3NbY2hdKQ0KPiAt
CQlyZXR1cm4gLUVCVVNZOw0KPiArCWlmIChyemcybF9ncHQtPmNoYW5uZWxfcmVxdWVzdF9jb3Vu
dFtjaF0gPiAxKSB7DQo+ICsJCWlmIChwZXJpb2RfdGlja3MgPCByemcybF9ncHQtPnBlcmlvZF90
aWNrc1tjaF0pDQo+ICsJCQlyZXR1cm4gLUVCVVNZOw0KPiArCQllbHNlDQo+ICsJCQlwZXJpb2Rf
dGlja3MgPSByemcybF9ncHQtPnBlcmlvZF90aWNrc1tjaF07DQo+ICsJfQ0KPiANCj4gIAlwcmVz
Y2FsZSA9IHJ6ZzJsX2dwdF9jYWxjdWxhdGVfcHJlc2NhbGUocnpnMmxfZ3B0LCBwZXJpb2RfdGlj
a3MpOw0KPiAgCXB2ID0gcnpnMmxfZ3B0X2NhbGN1bGF0ZV9wdl9vcl9kYyhwZXJpb2RfdGlja3Ms
IHByZXNjYWxlKTsNCj4gDQo+ICAJZHV0eV90aWNrcyA9IG11bF91NjRfdTY0X2Rpdl91NjQoc3Rh
dGUtPmR1dHlfY3ljbGUsIHJ6ZzJsX2dwdC0+cmF0ZV9raHosIFVTRUNfUEVSX1NFQyk7DQo+IC0J
aWYgKGR1dHlfdGlja3MgPiBSWkcyTF9NQVhfVElDS1MpDQo+IC0JCWR1dHlfdGlja3MgPSBSWkcy
TF9NQVhfVElDS1M7DQo+ICsJaWYgKGR1dHlfdGlja3MgPiBwZXJpb2RfdGlja3MpDQo+ICsJCWR1
dHlfdGlja3MgPSBwZXJpb2RfdGlja3M7DQo+ICAJZGMgPSByemcybF9ncHRfY2FsY3VsYXRlX3B2
X29yX2RjKGR1dHlfdGlja3MsIHByZXNjYWxlKTsNCj4gDQo+ICAJLyoNCj4gDQo+IGJhc2UtY29t
bWl0OiA2ZDU0ZWY3MTYxZjgxNWJlZGVkOTQ4MzdiNDBhNTIyZGY3ZmQ3MTc3DQo+IC0tDQo+IDIu
NDcuMg0KDQo=


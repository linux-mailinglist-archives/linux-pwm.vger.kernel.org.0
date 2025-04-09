Return-Path: <linux-pwm+bounces-5417-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A5FA82A38
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 17:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB3F188C9E1
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 15:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1A9267392;
	Wed,  9 Apr 2025 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cay1soyH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nfa4U88I"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53387265631;
	Wed,  9 Apr 2025 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212154; cv=fail; b=GiI0+J635LEYf+YQeqqF2TQtTYyYOLNk6byfIhPKkb5gG4zudzX3YD1lybB9ZnSyGBUkYU/RT5fhhUUjaylgjMj0IA79uCUFF19sfw3mvmGQwfI3cc9l9StmwZr2OIStACdb8znqwAxgcM8Hpb6VGvKzopQPSqKynrty/c4Qp08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212154; c=relaxed/simple;
	bh=pTzMOixkykVauWLj72uzRRxhv62R5nFfZG/t9JTEMik=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XjGHTF9mJAPr8CzecNbkRdZ+3f8+QAX+oNIJBqSjeLbdL7ifmkp6GSv7w24irsTL3XQSivQ/l8iSr1MxYQyBhlGPtp+7EsL4Xd7yBH/qIJyjoD1w/DEffDl4WjVmLZTNWJXLsJsuLRzKxFZYj3EV804Cgxe8nB9NO38lsvkMpSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cay1soyH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nfa4U88I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539F1uCp023617;
	Wed, 9 Apr 2025 15:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=H+fqjJy0bCsiVuv2Gu9tQldEpYnf8xgv736vOfaQsP8=; b=
	cay1soyH/3EJJdrd8y7ZtDOqDbxDguG5XmAR2Vm3rF5BB0EFbixvNzLCI9RcDEcx
	7p7R+uwLW2MqpEnRleSHhvyqukraKCqT4fXejaxdhjYBkrSZYL9Fnvpjh2T3wzRT
	2u71F9FJBAvoLAy64owS9oB3UrAZmJ/D5IzZLoAnPbNQSlANdQMRCCYsgQl74sgJ
	Cj67dWOdTcWigNpsIoOscfa7VDehWNPgShlBKCyW7y0SgSMG5sft2gTrpgeFzXaA
	ZZuON6d0GsSAmMaTPXA8zQCFflfhHkRbXyiyFLkh/bd6omnAYLodFEe19pS/L0lK
	p/Nw71V8y0g9REaRpOdY/g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tuebqf86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 15:22:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 539ER9Dv001900;
	Wed, 9 Apr 2025 15:22:21 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazlp17011024.outbound.protection.outlook.com [40.93.13.24])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyaxnm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 15:22:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfQX+5tFwDnCDuBWhfL9xvy4lxEfqAiLles+jhTNFdMmjvKKM+rWRKZQdtW3QsGzdZG6EnrmWT8kOqk1U8Oq8S2BvHJMBRRUOjZbPGnRQycixzq+pUpTT+DuCFugMHvbNA1WhqtILOiO5AV0mNsm0o4zMXJQnkJbErKX6HsGfZygb514vDKj1BFDDGda7zke5cNh8szNJ3TXPrdEdxQTBw0cpMzV6PkOFOr7h/2Iu5I2LGUsKKPZH9DZp+OFHK5/A8b3maNgVuTTKWVVEagc+zzvqhrweFrZj/AQECTLZ2LpsPUUrdyCTOj9bV+TF7X4rX/R4M2VqyrLSlIdddS+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+fqjJy0bCsiVuv2Gu9tQldEpYnf8xgv736vOfaQsP8=;
 b=KROpsCd4LqMAw9eQeAdyYci6580OqqT442Rgs2Q/bO0q+LEEJiOPxPn/83f3s08UuCEO+nItL8GcxYIwrW7vSwd2eY+W8uHhh2FRVF9sgGxvED+K9lROOf5L1hbCpz7Mq8euVueVC4BxsdlhiL7vZtSj2MCPyEpZZrL0xemrde00YADB2y6FNqbjeGxf0w2zjuX/4EblQPRZZVWe+JQB6FRl54Ruj9ZAZ+W6x3tOlTGCSQ+P0NqcvNLgTgN0bMFeuiFuiHJ6Wlcn4ot8MBqb4Oq/texkkfExDE1bqoAQ18PQgWHNRdHTQNpHBbIuWoa11cWmdtbR7G0g4e8kdVHXTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+fqjJy0bCsiVuv2Gu9tQldEpYnf8xgv736vOfaQsP8=;
 b=nfa4U88IZJyjWQqTs21MTYlf8M60QGe+8aZlFOVN2Qrz6RoJ2hThvzGYSZ4aFLwlzA5cYpwwgFE81H75ocImWK6E8vVzay7A5KW7MLybn37JkJNWV9dBSAD6ByADllz9zaapHwQGSm6GCnx6trpZ4nAE+mz8mn4Vw+qRjtbO4Dg=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 15:22:13 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%6]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 15:22:13 +0000
Message-ID: <a9d8ca30-3836-49b3-898c-c351b2c44a76@oracle.com>
Date: Wed, 9 Apr 2025 20:52:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v6 01/12] dt-bindings: mfd: gpio: Add MAX7360
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski
 <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com,
        =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
 <20250409-mdb-max7360-support-v6-1-7a2535876e39@bootlin.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250409-mdb-max7360-support-v6-1-7a2535876e39@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: bf120a27-d641-42cf-3bac-08dd777a4dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3prZ3Z1V2hheE5YRVRjei9nSm1QYWlXZWQ0Zk53eFF2NElobzJWb0FMVDd3?=
 =?utf-8?B?VzFqdzJoTlRGdHh0K3hHbk83emVOWWJHY3hza3cxdXZYb0gzbHRzb3g5TktD?=
 =?utf-8?B?MWl6bGdXN3prdndUdTAwK3RsNXVmc0RSS0tBWjAzSnU0TmhqcW1tQzZuR1hZ?=
 =?utf-8?B?N0orZmlKVTIzTGZLTVIrWGc1SGFGQzFFVUZsL0lkUzR1VHVlektRYUVwQ3Rz?=
 =?utf-8?B?WTN0cFNwSlRZdEF6VW5oVS9HeEJHdnE0TnV2bjhxTzkwTk43Q29abVh0NC9o?=
 =?utf-8?B?TEVtT0NEenZnK0puaTFpUE5zTG1CYnVmdUFvVHZBYkNONXpDT3hJd3BqZU9i?=
 =?utf-8?B?UVhsZnVzQTQ1cHRUa2M0aXIySlhDRko2QmdGUVl0UHdocTVxT0JDUlVaL3l1?=
 =?utf-8?B?ZVlSeHBydktHblNmNkswYTNRMVVhc0Q0RFlIRGwwendxZW9ZbGpKVGFTZXlF?=
 =?utf-8?B?bTk1WStUcHhtKytOODNhRDhla2VoRFMwalRMeTl4ZVBaTGxNb013R1VGcHYy?=
 =?utf-8?B?djh6NnZKM04zUUVMZzdXN1Z0ZG5Da0ZtZVp5NlNjQW4zVzErQlQyN1BEV0ZH?=
 =?utf-8?B?RVAyd0VoRGc5MHAyQ0tjV2RzSzhIcUREQ1JKOEFkR1N2VUNzRG1WcDdleEU4?=
 =?utf-8?B?YUlXRGtjME5RZjh4Tk5DTW96Vm5yb0NiK2w3REFHeHM0S3VTcDIxZ3pZVjhp?=
 =?utf-8?B?L0IweW1Uek1YZVVzWjhoU3FFR3ZmSHdxRnlmUVFxN2tXbTlLZ2tBTXZmY0NW?=
 =?utf-8?B?V3E4QS9VZFNRVmxRSU5CaGZkR2k5d1V2d29BbmZmb3RpSGIvOGxmaFdQM1cv?=
 =?utf-8?B?bzB1KzE0LzQySTJCOEFGWnM3cDN2cnRtUHd1MFpBSlhyQ2FEZG8ya0RuTzZl?=
 =?utf-8?B?MUN5QkVnN25kWkZzdmhvUGwvRDJRNVh4bFQvODdiTCtyY1FMR3pSdVdBa3lB?=
 =?utf-8?B?dnJDd0oxb29yN2UzeUJHcHdWc01ycC83Tmw2L1gzTUxUcXJoSXFOV3BtVFVx?=
 =?utf-8?B?dy9JSkZZN3MrK0w4cGwwMTZKY3B2ZWZJUVM5V3h6eU5OYksxenNRc21SRGRE?=
 =?utf-8?B?RzNtQ2ZyeHFKUUYvNFJ6N2JzSkNwTndha2o1eDFhZlNyR1Vjd3Zyam9GdlU4?=
 =?utf-8?B?UFhTRXdON1JHL0ZnckZreDk3ZnRKaTJuUWpTL1dtREpyMCtlMEJrNHV5L0RV?=
 =?utf-8?B?MmgzN3M2Rnlnbk5xZUZYQnE4bjd1ZmcrYWZ6UHBvUTJmSXZOb3poQm9rby9i?=
 =?utf-8?B?bmNXOEY1eHN3aGxiZWxTZ253V2dFR2lpdTE3dlh0TjllR1VTNHRZRUh6aks1?=
 =?utf-8?B?MUYwenp3LzBxUmwrVUNxYzVoUUw3U1JrcmdqOVlUaWU3OGJ5dXY5clpZSm8r?=
 =?utf-8?B?V1g4cEprUm1JNHBJeFBSSjV4dXlQQWVKcnZKdVExaHJHL2EzSGFlOHBIajVH?=
 =?utf-8?B?UU91d2ZnRm5mYjFVamNzc1pLbkZtZkEvNmMvWTVmQWtmbFZTWjRmdTZ3OGlq?=
 =?utf-8?B?R2JKb2Jvclh4NTJaRVJBeFZEZFBqQlBEYXl2UVl1RXoxbVo1bUNxb2s2QUVs?=
 =?utf-8?B?TCswaktEYk9BNVlhS2V5ZXFiM0hxYWxYemNIVExLaTJMNDlFbzVsTzBDMEZa?=
 =?utf-8?B?M2I1WGFLRFRLZ2FNOE5XWEhWR2NRemVmS2J3djFoemRYQkY1a3hzMmxnVGMz?=
 =?utf-8?B?T0NFbnQ5d1FDdmw1YzNRQmdWS0J4WUJ5NXNKMVRoWEhleEVzUEM5Zi9ScURp?=
 =?utf-8?B?NVFOZm5ralN1WVpJWUt0eXQ0UFB6RnhYN3YraXgwS3ptcWpyZG9XeWFLMndt?=
 =?utf-8?B?eDV6c3ZSYURJbk5pM3RWWFhaRWRBUW9LTmlDeUx6Q1pmMUJDaDFKOVFKeVJz?=
 =?utf-8?Q?tLK9tfdwKa2c5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzVqaVJFamltbEMrWDBLTjVoaG1nNHBjcWpIK05iWUpWdjdSWFNBYWhYSFJu?=
 =?utf-8?B?ditMd0hUak9JVExpZjFyOFVnSXZoTEdmbUMyV0ZDWm9zL1FJa052VzJmSCt4?=
 =?utf-8?B?Q3hiNzk2UGVqOXhQVWI5RE9wN2FDSkdVek9NVnZDL1ZDV25vdko4VWFEMW5n?=
 =?utf-8?B?NTZ1aHRQaE9HZlVidis5RFlmclZ2akl2Z1FuTXd4SFI4ejJYYXIyYXVIREhK?=
 =?utf-8?B?Y3hGcGsreTNUTnBIeHdRbUdxdjd4WGdDeE5LS3gwbVZVV1JDbVdTUnFnMlhl?=
 =?utf-8?B?T3EwRnhQQ2k1YzA5eWMveDcySWVwWE5DYm1TeERWS1l4SGpGNmIxVDdsUy9P?=
 =?utf-8?B?NWZmUlJoQmNJTVUxVjlhQjAwSnlkWnlGK24vUzJVbmdEdnp0YzFGb2dXVTI2?=
 =?utf-8?B?UDFGSi96ampuZ1dkNDV0NU1hZkdTSHpUUjVhb2tIRTJ1SThIY0N4aW1MQXc1?=
 =?utf-8?B?dXI5M0RQTU4vcmRBdU50NURreko0WUF2amU4bHZyVFkxQWNFTDdtcWJwaFVr?=
 =?utf-8?B?Z0RUc2NYdU9wUmhyTkhxR2dmbmRTZUtmaEJPNkhud1FLZkxFMkloandZMmJh?=
 =?utf-8?B?UXlPemFRUGpPaVpIdElpaWEzeTZUcTd0ZGdLSTJhNG1ucDZzcVJ2dDNNTEFJ?=
 =?utf-8?B?S1dxa1IvTmQwR0g3N0tCbnpDdEswbmV2NHo4cEhpMWI2ZFpKVEFXaElkblh2?=
 =?utf-8?B?R2R1MHhiSkZwQmJxTjl4d2o1YTBTMDNZeHBnd05HMlovemR4cmRsRXZ4TDZi?=
 =?utf-8?B?eThrM3p6WVZkUjBOZld4SVBFRi90VFpwa09pd0tKQjNnOXovMmNiZEl5OUhh?=
 =?utf-8?B?WlF2eUtoeU9DYWZmUm5WaStyVUMxdjd3bE5aVXJybGpySW5oNG5TTWtJcG8w?=
 =?utf-8?B?QTgrUTZJWEhPMGhNTzNhMXdXZkhLYm1DbjFFT21GQlFScThMSmhuSHpuaE1q?=
 =?utf-8?B?b05Qa3BVVDNESjQzV01FNzVtYkkzUlVZWkFFMEs3bThaaWFZb2ZxUkROa1Jh?=
 =?utf-8?B?RFIxeEdoVFJaTTJEVXQ2Mzd0a0hMLzBITFpXRGtUUE5USGhwWnU3NktnOGJI?=
 =?utf-8?B?RFJVKzVoQWwzWHMvM0tpSnNNVGhGcFRvM3AzWVZnNTlDQ09GZG5FMC9GMVg4?=
 =?utf-8?B?d2hNQk92WlUvemF5WlY0OHZhdy9Ra1Vjb1Mrc0pnd0VWQis4K2pERjA4Y1FZ?=
 =?utf-8?B?QldGVE9KNWR1Z0ZrKzlyNXJoNFBqZ0ZoK20xMTRPOWZkSlhJWGRMd2thMkgy?=
 =?utf-8?B?WHVKeDd5TUF0YmxGWUJYQ1VoRDRiaUlublladGpISDl5THpKWlVsSXZGbklD?=
 =?utf-8?B?SjI3UmNZTVE5K2ZLK1F2d1ZJRDZqMFhqcHBTSHVlVGo0ci9zU1Rpd1VJTk5T?=
 =?utf-8?B?aHV2R2VUZkxaOGdObzYyOFlRZTZPWTNKTFhuakFCVVI3bDhHUU5keDF3Ykp5?=
 =?utf-8?B?ZlJoUFMyaVgyV1FVZHRXc3lJbFAzT280R05DOHdOc0oxMEtJWUxmaUhITlBX?=
 =?utf-8?B?ZDdVZVdwL0xQbDlLVXJaK0d6U1VLbGNUL2tFU2ovUmJ4d0VLTlI1SGljc0c5?=
 =?utf-8?B?QWtvK0pzYXVOWkF2MWRiTXJrZHUzbzdOWUd0ZVZLTSs4cW1hQjFFcERjRlN5?=
 =?utf-8?B?N3hPcmNudGpmMHpWR010ZWowOHN2Skp1eWV6Rk5WaEFCWllOdzJmeDFyQTNp?=
 =?utf-8?B?amo3M3BqRnM0WHVwTmJzZGNHVUZCbWxLNThGZVRndTNOLzRzZFN1TWNlK1JH?=
 =?utf-8?B?a0gzZTdOZlg5ZVVLUU9XR3BQTlAvR0dndTl0cjZxNGJ4YkQyZjVDQTVHOERK?=
 =?utf-8?B?RG1NN2I4YjZpU2picDlhb3ExQ0VWS1laWE1IOUhUUElNajFTZ0R4WXJpSHNY?=
 =?utf-8?B?aDhpM1NOQXlpRnZVVGlQZnphQXAxUEQrZ05WZ25UOWhQZTZ1REZzaVdSdjl0?=
 =?utf-8?B?RFZtbWx5NGZkUFJRQmZFMTRGU0VtTkM3MHVTcGF4aHpwOW9hcWlPRks0VWly?=
 =?utf-8?B?QlAvbFFmaFRyaUlnVUZrWmx4VFVWd3JTVmt6cE9xSFowMWNxTTN3L1hYMTRh?=
 =?utf-8?B?S1kwZDFXd2JwNmxLcEE4RHhZa3NYcFM5blYvbmc3WHN1amo3TkdlclFsYmdj?=
 =?utf-8?B?c254SFJLZ0p0dWRBU1FzZHFyRURscDVYMXVwQ0lVeWdPTXMyLzE5ekZVV0p3?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dtU6T4A8YkZrfrsy5Or+b5xB9zgV5Dd8jomJwq2g3FUaiXhoM75E0Pf5w2IgKMIPZ0JoxU3rIXJpTz8ahXrZh2rmseDfq7Z/wtGpKBUpm0e0XmQSvOmbbyOSnKJnudn7NJECOs7vAuJSzeYm82F9BvWKTw/GM0MvK7UpSFOIm31v/KupZ8QAl8aFEObBslepWXbFIsqWOVMS1IfnO73TXGxhA7fLcUjB3F81uDdFvRD4MkfPhn3ZrjnWBQSgmpfOSEr92/Zo5spBJcZIMlfajAw4FEHDHdlW/N5zbFYR9yRB70UazTNsPu3GKDqod6MXxP0D8YoW9B8ezfhHT4zItDBoiJCw78FPL6//D79KAEPrgPq2GcK6llMRC8GaZjiZON1Ig+RaMNjJ9KHMGj9gsEn0bMe/sSr4DF3eHmqAgKzFuqVYg7nvPOTIjftLNQOmXmep6ITLSY2lSIxivCv5GTyeKf/KCTNVFfSytd3TR2SXMuVOhn52/vbogIn8Qn8vxg94pCsJNyJmQuMoZRGjonhQ/tLls76azuWzUyv0YB58PuhKZpr883iGhKIFcLXp8bJxkBIRUbf9ZviSdieLOVHxPQQDHiw+hCkvRtDhkAI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf120a27-d641-42cf-3bac-08dd777a4dcf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:22:13.4809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZaBBe44GIm+C+uyIjG3Iupts5B50LYh1zSyyWqqNo1F27wQjRENiZKs9fbZDaU2Tekfb+CUuQWSVwDJUUGUQpte8JY20a+MTNQUelvfafM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504090097
X-Proofpoint-GUID: 0juzZYgo5LoyKS9QsJmmVN7vBwJLERZ0
X-Proofpoint-ORIG-GUID: 0juzZYgo5LoyKS9QsJmmVN7vBwJLERZ0



On 09-04-2025 20:25, Mathieu Dubois-Briand wrote:
> Add device tree bindings for Maxim Integrated MAX7360 device with
> support for keypad, rotary, gpios and pwm functionalities.
> 
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>   .../bindings/gpio/maxim,max7360-gpio.yaml          |  83 ++++++++++
>   .../devicetree/bindings/mfd/maxim,max7360.yaml     | 171 +++++++++++++++++++++
>   2 files changed, 254 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
> new file mode 100644
> index 000000000000..21d603d9504c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/maxim,max7360-gpio.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: https://urldefense.com/v3/__http://devicetree.org/schemas/gpio/maxim,max7360-gpio.yaml*__;Iw!!ACWV5N9M2RV99hQ!LySDuQZdU3DANTEmkRlntMCbFm69zp24O0wAwuujlnN1Zh9-xPEHZu7fj5d_O7vIxUHn9b6gqg9MHtd9ntPvXQvakCad_v0$
> +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!ACWV5N9M2RV99hQ!LySDuQZdU3DANTEmkRlntMCbFm69zp24O0wAwuujlnN1Zh9-xPEHZu7fj5d_O7vIxUHn9b6gqg9MHtd9ntPvXQvacsB3d9k$
> +
> +title: Maxim MAX7360 GPIO controller
> +
> +maintainers:
> +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> +  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> +
> +description: |
> +  Maxim MAX7360 GPIO controller, in MAX7360 chipset
> +  https://urldefense.com/v3/__https://www.analog.com/en/products/max7360.html__;!!ACWV5N9M2RV99hQ!LySDuQZdU3DANTEmkRlntMCbFm69zp24O0wAwuujlnN1Zh9-xPEHZu7fj5d_O7vIxUHn9b6gqg9MHtd9ntPvXQvavZnHZJk$
> +
> +  The device provide two series of GPIOs, referred here as GPIOs and GPOs.
typo: The device provides two series of GPIOs,
> +
> +  PORT0 to PORT7 pins can be used as GPIOs, with support for interrupts and
> +  constant-current mode. These pins will also be used by the torary encoder and
typo: ie rotary encoder ?
> +  PWM functionalities.
> +
> +  COL2 to COL7 pins can be used as GPOs, there is no input capability. COL pins
> +  will be partitionned, with the first pins being affected to the keypad
> +  functionality and the last ones as GPOs.
> +
typo: partitionned -> partitioned
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max7360-gpio
> +      - maxim,max7360-gpo
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  maxim,constant-current-disable:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Bit field, each bit disables constant-current output of the associated
> +      GPIO, starting from the least significant bit for the first GPIO.
> +    maximum: 0xff
> +
> +required:
> +  - compatible
> +  - gpio-controller
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - maxim,max7360-gpio
> +        ngpios: false
> +    then:
> +      required:
> +        - interrupt-controller
> +    else:
> +      properties:
> +        interrupt-controller: false
> +        maxim,constant-current-disable: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gpio {
> +      compatible = "maxim,max7360-gpio";
> +
> +      gpio-controller;
> +      #gpio-cells = <2>;
> +      maxim,constant-current-disable = <0x06>;
> +
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +    };
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml b/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
> new file mode 100644
> index 000000000000..ae3969d8dc8a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max7360.yaml
> @@ -0,0 +1,171 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: https://urldefense.com/v3/__http://devicetree.org/schemas/mfd/maxim,max7360.yaml*__;Iw!!ACWV5N9M2RV99hQ!LySDuQZdU3DANTEmkRlntMCbFm69zp24O0wAwuujlnN1Zh9-xPEHZu7fj5d_O7vIxUHn9b6gqg9MHtd9ntPvXQva3_poDnI$
> +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!ACWV5N9M2RV99hQ!LySDuQZdU3DANTEmkRlntMCbFm69zp24O0wAwuujlnN1Zh9-xPEHZu7fj5d_O7vIxUHn9b6gqg9MHtd9ntPvXQvacsB3d9k$
> +
> +title: Maxim MAX7360 Keypad, Rotary encoder, PWM and GPIO controller
> +
> +maintainers:
> +  - Kamel Bouhara <kamel.bouhara@bootlin.com>
> +  - Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> +
> +description: |
> +  Maxim MAX7360 device, with following functions:
> +    - keypad controller
> +    - rotary controller
> +    - GPIO and GPO controller
> +    - PWM controller
> +
> +  https://urldefense.com/v3/__https://www.analog.com/en/products/max7360.html__;!!ACWV5N9M2RV99hQ!LySDuQZdU3DANTEmkRlntMCbFm69zp24O0wAwuujlnN1Zh9-xPEHZu7fj5d_O7vIxUHn9b6gqg9MHtd9ntPvXQvavZnHZJk$
> +
> +allOf:
> +  - $ref: /schemas/input/matrix-keymap.yaml#
> +  - $ref: /schemas/input/input.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max7360
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2
> +
> +  interrupt-names:
> +    items:
> +      - const: inti
> +      - const: intk
> +
> +  keypad-debounce-delay-ms:
> +    description: Keypad debounce delay in ms
> +    minimum: 9
> +    maximum: 40
> +    default: 9
> +
> +  rotary-debounce-delay-ms:
> +    description: Rotary encoder debounce delay in ms
> +    minimum: 0
> +    maximum: 15
> +    default: 0
> +
> +  linux,axis:
> +    $ref: /schemas/input/rotary-encoder.yaml#/properties/linux,axis
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +  gpio:
> +    $ref: /schemas/gpio/maxim,max7360-gpio.yaml#
> +    description:
> +      PORT0 to PORT7 general purpose input/output pins configuration.
> +
> +  gpo:
> +    $ref: /schemas/gpio/maxim,max7360-gpio.yaml#
> +    description: >
> +      COL2 to COL7 general purpose output pins configuration. Allows to use
> +      unused keypad columns as outputs.
> +
> +      The MAX7360 has 8 column lines and 6 of them can be used as GPOs. GPIOs
> +      numbers used for this gpio-controller node do correspond to the column
> +      numbers: values 0 and 1 are never valid, values from 2 to 7 might be valid
> +      depending on the value of the keypad,num-column property.
> +
> +patternProperties:
> +  '-pins$':
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: /schemas/pinctrl/pincfg-node.yaml
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          pattern: '^(PORT[0-7]|ROTARY)$'
> +        minItems: 1
> +        maxItems: 8
> +
> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +        enum: [gpio, pwm, rotary]
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - linux,keymap
> +  - linux,axis
> +  - "#pwm-cells"
> +  - gpio
> +  - gpo
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/input/input.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      io-expander@38 {
> +        compatible = "maxim,max7360";
> +        reg = <0x38>;
> +
> +        interrupt-parent = <&gpio1>;
> +        interrupts = <23 IRQ_TYPE_LEVEL_LOW>,
> +                     <24 IRQ_TYPE_LEVEL_LOW>;
> +        interrupt-names = "inti", "intk";
> +
> +        keypad,num-rows = <8>;
> +        keypad,num-columns = <4>;
> +        linux,keymap = <
> +          MATRIX_KEY(0x00, 0x00, KEY_F5)
> +          MATRIX_KEY(0x01, 0x00, KEY_F4)
> +          MATRIX_KEY(0x02, 0x01, KEY_F6)
> +          >;
> +        keypad-debounce-delay-ms = <10>;
> +        autorepeat;
> +
> +        rotary-debounce-delay-ms = <2>;
> +        linux,axis = <0>; /* REL_X */
> +
> +        #pwm-cells = <3>;
> +
> +        max7360_gpio: gpio {
> +          compatible = "maxim,max7360-gpio";
> +
> +          gpio-controller;
> +          #gpio-cells = <2>;
> +          maxim,constant-current-disable = <0x06>;
> +
> +          interrupt-controller;
> +          #interrupt-cells = <0x2>;
> +        };
> +
> +        max7360_gpo: gpo {
> +          compatible = "maxim,max7360-gpo";
> +
> +          gpio-controller;
> +          #gpio-cells = <2>;
> +        };
> +
> +        backlight_pins: backlight-pins {
> +          pins = "PORT2";
> +          function = "pwm";
> +        };
> +      };
> +    };
> 

Thanks,
Alok


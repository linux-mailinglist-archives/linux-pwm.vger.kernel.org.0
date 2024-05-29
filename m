Return-Path: <linux-pwm+bounces-2289-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2768D342C
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 12:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B751B23B9B
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 10:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87724180A85;
	Wed, 29 May 2024 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="PA2zQN4l"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2122.outbound.protection.outlook.com [40.107.105.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EF017DE17;
	Wed, 29 May 2024 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716977465; cv=fail; b=PaCIm3q6kWJEiFHt3YtU9HC269xiVHbH51pLk35+O0+SuxisxvAdObm1yh2ji31GL2NLAgCn6Ny/4SCF80sf6QVZYTmQm11n6lM+hfVbXnMrPWJWQUR69pftgu7TPOntbIbIP/WuhUmTwowEagi1Q5/0SymHuFpACuimjMRKWwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716977465; c=relaxed/simple;
	bh=el/JZui6qgPQYUOpepQP+4U29kzWjmzMPssI0ZhI+qU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KUuTekeCZtZ1O34GcxCsXR7ZYamAPsH8FhvsNvSz42nqn8VKXWqo5MiBGy/p4kRIHgbVdCtdmZb6akPuD/o066QNJNUZ7hivj2bt7yC+ZjoO0kU/a71G5smVo5rZIoosRF4H6qFVbMq97xH0epmw/dN9fcbsFyIxIxZ2lTTrd6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=PA2zQN4l; arc=fail smtp.client-ip=40.107.105.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ii8+LGl2Yjy6kAIuV6M7tpIT0IJto7GTnr7h6jmCEpZJ4QAq9ZR15j9Zbs9Tbs1ePvCJ1T0Alvbm1e8Nx90vWkgTBMM7tuf/+BKnDlMVyUj4ifH1ebMF28mk/1KehWYx+311grscqWJX2+aNda3v+I7//iHW8DTPEeu2YdtjyyvepR/X7vH3zh0tgzCwxWXyVEt6aPNAy325rOjQjnqP+nK6DqQPwzNmLuILabcknr/oK/ipQ0F9fHngjrT7ziadVy5tS6sg4TEytcGGWM+Ki+WBGXOZF57L0Mop3FsUqGqDze5miE+a9o7MTtq5gCet3EDTCk1HvZLwBo429JtRvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xENk2PqkKRyIU4NuVKHl9fpCj9f0GkGfa0R1ccqXcdg=;
 b=jsgO1ugvWj8WwaTCy44euTbqfLHkHqCo6oCrkFgBF2N88ZvmQvSRBVotQ4EuuC+vlF0V1m2cXAr2BZhTmD+n0/THG0QxaBFqcNfThfMq9KrODEMT/e7A3eH9McIkAAOXu/ngQhgxeeflQUjq11JwCysaBsaVByQyqFg/xeAcK2Kycag2vQjKRnrTsugM6lFMPGtsHSCMKt4v7JOC0QKV3JemmjfiRVjUH3Pe311oA2lMo0tpPGegKovI/zMBsLe1pwiCmMlssD5aysG+U+cFwR8D/QVRozUeWMN6YXzL9UQy+rBFHKKhVJcCEHCk9qlGcVC9PvCcuzEiynHPDI3NWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xENk2PqkKRyIU4NuVKHl9fpCj9f0GkGfa0R1ccqXcdg=;
 b=PA2zQN4lvPrRD16EmNRbtNrceuhTGxbNKTjAob1uBmkTh61Wzbw7tZDGdX1bNSPahIYQMptUjK/hXWCdeOeB0EdKlCTthumzzloC7yGN39rE9BuY7/HOiaQJQLxLVuREq/UnxYkIi7ktbLkT301coX98TRHEGeClF/eHSnUfOKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com (2603:10a6:803:122::31)
 by AM9PR04MB8811.eurprd04.prod.outlook.com (2603:10a6:20b:40a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 10:10:54 +0000
Received: from VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6]) by VE1PR04MB6382.eurprd04.prod.outlook.com
 ([fe80::2a24:328:711:5cd6%4]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 10:10:54 +0000
From: Farouk Bouabid <farouk.bouabid@cherry.de>
Date: Wed, 29 May 2024 12:10:33 +0200
Subject: [PATCH 4/6] arm64: dts: rockchip: add pwm-beeper to
 px30-ringneck-haikou
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-buzzer_support-v1-4-fd3eb0a24442@cherry.de>
References: <20240529-buzzer_support-v1-0-fd3eb0a24442@cherry.de>
In-Reply-To: <20240529-buzzer_support-v1-0-fd3eb0a24442@cherry.de>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Farouk Bouabid <farouk.bouabid@cherry.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: VI1P194CA0043.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::32) To VE1PR04MB6382.eurprd04.prod.outlook.com
 (2603:10a6:803:122::31)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6382:EE_|AM9PR04MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c76834-dd87-4cee-5097-08dc7fc79e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|1800799015|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHBpT2taY2d6amV3QkVobXZqbXNTOW84Tkh2RzZPaUwxODVKYkpiSkNLcG1E?=
 =?utf-8?B?d0V2YmhJOGJCUDM1RjJ5dTIybGc0MlkrKzNPeTBJb2JiYjYyditaWCtGeXFV?=
 =?utf-8?B?eUpBWkU2QVNkUHZMWTNKaEJndWs3aWwvdFEydENtSjZ6aWFHVmFtTHdKQWU5?=
 =?utf-8?B?Z2prbVlWUm56NlpTL3gwWGdrcVk2UmN3MTlzeHB2bUtGT1NOTGpMK2VTYTd4?=
 =?utf-8?B?dDFVUUw5NFhkdE1iTHRDdjBUZHY3NUp4Zkt4Ym5aVzQycjNjaFo3dTN4Mi90?=
 =?utf-8?B?ME4reHR6aHdZYVVzNUZsbVhsNVlBckRXYUV6TjRiZVFPeVd5bUZ0RnV2QjFJ?=
 =?utf-8?B?eS92V2Z6T0VRUWJkRi9wbkd2QmJndGtTMVNKQVFNS0o5ak1mM2Rsd1Frb1cy?=
 =?utf-8?B?bnhwbTk2RmZPYlZJcCtGampIUXl0MlBJbkRXWnBJZ3VpbDRhcFprcVUxdFcz?=
 =?utf-8?B?bDBrdERvS1hsQkxkVlByLzRxdE5Td1lsTHJSQUF6Z1g1ck9zRTRkZWIvWk1C?=
 =?utf-8?B?L2Z4cmpJYW1tMG14RUNPMnVIUk1majZvSHVZSlRMUHd0bWFoUFdkYmREd28r?=
 =?utf-8?B?Q1llRi9BNmEybk51WTZhak1xaDBWVDhRUzM0OWFMYWhJSVRSUEthN0FYdUUx?=
 =?utf-8?B?aE1zUGFhbWxTcVdxTHh6b2tQYUpMQkJzK3FaTGQ1K1cwY2w2Y2l5cG9NQnM4?=
 =?utf-8?B?S1hqdVZCdCtMamcxeTJmb1ZibnVydnVkSUg3dnEzNmhQVmNVSXo4ZGo2Z0lS?=
 =?utf-8?B?VTJYbEljcGNnYjNsOStVWHdSbVNSRkFOZ2NwemYvMlEwREhFeG50NkpHYlVQ?=
 =?utf-8?B?aGI2MTZFK0dQVjV2WG41MWpWYVoyeS81U1pZVkY5SnQ3Q2JSTnZoVDY4OHZ6?=
 =?utf-8?B?d0hxdUo4bjBwYjY2cmY2ZXoyZXpMakpGYmQyNTVSYXd4UlhaVThpcXB5T2NQ?=
 =?utf-8?B?WWcwOURLNTJIYjNPaml5K2ZHWk02NEIvWHlZUTVTdkxjazdEbWNPSUlWU0lp?=
 =?utf-8?B?NXFXM3J3Q0l2cUxZaFlvTEZvTnhrdGpNa0ZOQ09zUyt6SXdUN2xobmhrZGlL?=
 =?utf-8?B?UFhidGZ2eis2N3FpZUJ1R24zeUw0N0lsN1Y2cUxQTzFKQTg5ZzhyZGp2NnhN?=
 =?utf-8?B?Tk5tVVMrSlFCZ21HdjM3d0dqbkZYZjJzK040UWEraElvV2YwNFVHWXBmWjdk?=
 =?utf-8?B?L2l4cjRiRUhDS0V3c2NFWjNGaW5XY0VCTWs2THg5SUVYZ0hnMi9nOGYyQTZY?=
 =?utf-8?B?RWFFSkFXVU5rV1U2S3dRUUw1MGpEVkt2TXFQNVNYQVZGYzQxNThocFBoSDJk?=
 =?utf-8?B?dnBrdm9ZYUt6WXI4Z3RFbFBiTFg1ZXpsUWZQeFF2SUhxcSs4akxCcjhXeXE1?=
 =?utf-8?B?OWRBSEY4Y3NrNzFvTEN2VmY3VHRQZ29LcmdZOE9ObWhhYUpBcmllUmltdCtk?=
 =?utf-8?B?MU83RTE2OVIzZm9kZTZJV05iM0dqcjB6SjVhdjVaSjFBUU9WTmRya09oOU1a?=
 =?utf-8?B?K2ZpaGlUb0hUSmtmanRKNHNRdlVWaHhqWVMyd0VyNllYVHhCR1hZck14aG1o?=
 =?utf-8?B?V29Sd0JOWjlQdVJNVzJoa1ROODhVWFplTGJXOGIzL3A4NlRCZ2hGTEVUa09U?=
 =?utf-8?B?SkU2aWZBK2lEZGxocTRra2tBYW9XZzNaYXhmQ2pVVGQvNnFCTHlHdUVmcUdE?=
 =?utf-8?B?S0J5TkdsaVg2VzJQa2tkaU1keUkxVlFMdGZNZ3d2RVVuamdDaXpRdnJxOVpu?=
 =?utf-8?B?Y2s5RWN4U29BdnRrTzN1UTlNS3haMWd3SkxrMVdDMndQWS9KZVdMRU4vSFhz?=
 =?utf-8?B?MDZMT2lCcTV1RWF0TGpWdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6382.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZE5YRGVxVjhrU3E2NFZMMnlkK0ZjVldCU216blYwOWFXZ1cvS0Vyclh1UVEy?=
 =?utf-8?B?dGxPbm1tazJSenlLT1RiK3lJbmZPeFNOQnMyUkl3d0ZPWk1LS3JUeFYvOHUz?=
 =?utf-8?B?WjFKU08yelcyaU9aL05XeXp4QmhZdVpxZE9MRzBQQVF6ZVNzcysrVmxZNlRu?=
 =?utf-8?B?UFBPS0V0TmlXU1ZFbmpjRGo0WFNTc1dPYmNGcUhVTzU4ZXpWenYyU3M2Umdz?=
 =?utf-8?B?Q01CTmlLUG43QlNyODJJVVkzMlhlQlBMemJFRXFIMU1obzMvZTFTb1dUb0Fv?=
 =?utf-8?B?M2dSdDFGSjgrNHhpZmE2SWVDQ2RLbVF2d3pCUWJuaTd5SWlQNTYrRlBYaVQ2?=
 =?utf-8?B?K0FpbitPMmpoOHBnL1pFSkdCeCt5RjhKaUNTRkxEc3NCdno5YzdQdU5RVGUr?=
 =?utf-8?B?QWUyTGlhbWhqb2VnNU9ESEdXYjJtTlFUUWZWWU16dHcySnNtaWVrQkxXMGVH?=
 =?utf-8?B?cytwUjRNaUNtRTliNXFWOWRiTFdxVUQ2N214Vktlc3czOWcwakRTd3hQcUFt?=
 =?utf-8?B?eUMvUW1CTktyaGg3QWVIZ2VQZVgzdDhQR0VoTEpJTk5USTRkWTNyM2xhTjNv?=
 =?utf-8?B?aDRBTkRJTFRIcXhDOGh1RTEzc05qY1hUSy9MMFpYNG1wdWRhTHdZVyttSUts?=
 =?utf-8?B?WmxZWi9jejN4ZGRZcXovVnZ6bXcyRmVFUHFUNWtUaWdYRGxQc2M0OWVZQ1Qz?=
 =?utf-8?B?S2ZZVng3U1RWZkFOdEhBeEcwK21xa1h3ZzNBNThaeVhBbmpqYm9wVnNHTnkz?=
 =?utf-8?B?YjNnTlVmMjdJSXlIdE54YjhPK2tzMjZRQnIzbnRMS3ZDZld6dlpDS2xCenRH?=
 =?utf-8?B?QldWcGF0U2F5Z3I0T2h4MUlBb29vL1NsUkw2TnhUTW02TVhERXJYR1ZHd2k0?=
 =?utf-8?B?Ukw4QlhmNldtRFBYd3BsSHkzNDEyTllKT2VtRFpqbGp2YVoyamtIbDk0TG1T?=
 =?utf-8?B?RURFWlFiUHZGL0xIT1F4WDg4Mzh2Rk40ZnRhdE9udzRLVS9ZSVRhRkRrQTBl?=
 =?utf-8?B?dEQxa0NZUFZMc0xXd1ZjQVZXTmVFY1JlQVAvS0VMUWNCM3lKNlN1QzB6S0Zy?=
 =?utf-8?B?a3JEQmZuTzlrNWJwMDZPM1Rjak0wNXpQUkhRQ2RWaWhEQ0lwL2FvMDR4a2RI?=
 =?utf-8?B?Qi81UUV0LzNObzJ4S3JJbXRpY01ocHVZRTNJcGxiRGNyeU40T0RWSy9PWVJZ?=
 =?utf-8?B?WjFYQVpsbzhPb3V6YXA5L09UZU4wYTFmYldweG1Kb2lxbTlsRTBidytNeGVZ?=
 =?utf-8?B?UVArSmE0Sm1QZFMxV01HTmdnNDRhSWxyRlVXNlZEYkJMSW5rRUVNNVo4a0Fw?=
 =?utf-8?B?N3FrZU1VZnArYmExdTh1R2hFSEpIVVVxcDBRV0thYzNvRno1ZlI3eWlJUVN5?=
 =?utf-8?B?bzlCcWZIdDdFU0pYdXBab1FYNGp4MENhdGlTby9YM0JNVVI5Tmc1UEtxZjUv?=
 =?utf-8?B?MzBCelVXblBTY0hxNE9FSGhJOGoveHZMYk5FQ1NrUHc2bUxjS05BR2wyRTZQ?=
 =?utf-8?B?ZFIwU0FpRVpQZGhZbmNsTkExUmxIb1EvTEUyeGJCQkszOGFiRFZNL3hOT0lS?=
 =?utf-8?B?TFNwckhCTzNBS3VGcHZDeG1jQTNuTkZtVUV0b2dQQitqS2JIczRYWmlrZVgv?=
 =?utf-8?B?YTNTOS8xOSttSUdCTmgyWHNudzluSWx4SXhBQWdTMk9DTlFXL1duZS9pdXl1?=
 =?utf-8?B?OGdDUzV0SkVobzR1Um1qNU00WmxiTXlZblZIbHJFcVRERHdxVlBTZ3hQL0pH?=
 =?utf-8?B?RzlTb0NVL1VGVTlHSDUxK1lYcWJFdGJaU0VSSHA3dFA3Wm14bDNrQXlJSkYw?=
 =?utf-8?B?Z2dRU281b2lRakU3ZTFQdmcvVXBnNDlIajI1cCtxN1FSZnN4ZkhHKzRVb21E?=
 =?utf-8?B?U1RTMDJMVndOdlhqZjNRYy9VM2ZNU05rQnJwUExLZ2VXMHFZSHlpYXFSWW9u?=
 =?utf-8?B?NXdPek5meEo5L3hIMmVXbWpRSjlwUlZ3dmRXMWpHSkJ2SHRxM1ZKemFwcVBF?=
 =?utf-8?B?dnFia1ZhV0IwdVl0ekpHRGtwYUc2Wkx2cjVsTXNNaVRITXoyM0xqVUM1aU5R?=
 =?utf-8?B?azMrMlE5ZkFjN2hFV1RaNmRjbjY4OG9CUTlSQmRlODZTMTVISUlzVjY0VTdH?=
 =?utf-8?B?WXBXWHJ5aHBXQTdveWRYcEtRRmovZy90K2UyTzRmVHhQd3VKOERwRnJnUHBU?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c76834-dd87-4cee-5097-08dc7fc79e4a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6382.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 10:10:51.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBffK7FEu+7nbLp29wMYS6cN0FSIKJ4NNZqdNh+uKi1LCLQoBiglfNnJDme324Rbe0H1i8TCDtbFsWv7zSDqWgCBVFimgoM0GegUUGBlv6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8811

Add PWM-beeper that uses Mule PWM-over-I2C controller on i2c-mux (0x18).

Signed-off-by: Farouk Bouabid <farouk.bouabid@cherry.de>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts |  5 +++++
 arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi       | 13 +++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index ae398acdcf45..513ecb382ccd 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -17,6 +17,11 @@ aliases {
 		mmc2 = &sdmmc;
 	};
 
+	beeper {
+		compatible = "pwm-beeper";
+		pwms = <&mule_pwm 0 250000>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
index eea906379983..0eee06024484 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck.dtsi
@@ -10,6 +10,7 @@
 / {
 	aliases {
 		i2c10 = &i2c10;
+		i2c11 = &i2c11;
 		mmc0 = &emmc;
 		mmc1 = &sdio;
 		rtc0 = &rtc_twi;
@@ -309,6 +310,18 @@ fan: fan@18 {
 				#cooling-cells = <2>;
 			};
 		};
+
+		i2c11: i2c@1 {
+			reg = <0x1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			mule_pwm: pwm@18 {
+				compatible = "tsd,pwm-mule";
+				reg = <0x18>;
+				#pwm-cells = <2>;
+			};
+		};
 	};
 
 	rtc_twi: rtc@6f {

-- 
2.34.1



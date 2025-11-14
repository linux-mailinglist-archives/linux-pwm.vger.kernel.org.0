Return-Path: <linux-pwm+bounces-7629-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 64434C5CA98
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 11:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00034341910
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 10:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCF03128DF;
	Fri, 14 Nov 2025 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ADkkpXoN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013048.outbound.protection.outlook.com [52.101.72.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E159031329A;
	Fri, 14 Nov 2025 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116890; cv=fail; b=PPRmiJq+UvWBV9LkY7+A0rWrDp8D6f2rTjBNXBPaVQBEYrfwlYTpgLP/gCcmwIpinOMtOfo3t4WOTq7rKf+78xdr7GUP+MaseeNTdJ2H1N+kKzWJ4wWW7l7QmorhO9X1AfNNFmIlYFZKxl29FgBOx7POGvpXN4E4nPSYb0kr5yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116890; c=relaxed/simple;
	bh=WQ3LrTe5pNFEvHukY/f/IED52W4FmCA5HJLHH3xB2Jc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=r5An/sRSadXhHxV9+sPZKKkH7KnIZpaG4YCb9RWxaYS0G2q50EW6TabDznHZn+isgvc4AHiQw4ikFabpqjLIjIDkzycqACRBk5qHiIWbB1zmakRHXd6zZjsBDgIh8KjGCupHp6023nusrs1dg+u/KMJWmRf7RTSakKNWAZ0Zb1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ADkkpXoN; arc=fail smtp.client-ip=52.101.72.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KX8cHlnd/8ooZmi3KAOo7JYGwVt70opbwpoC8UDP/yBL+VBPztHXeFgebpGT01YWZXuKB000fclFs4N3i1L4rGkd541P8MP1IpkNl6b89+jn2PZpSJaCLqfFuStBZbjy0Qus/IblV8iczWhUdJSIP2jVOqhHGdrpr6cAMHXPapggyu1sRyPXUlKsTMzUaKGKxT0eJ8LOvt2bNKSdDqqkEncyH5+vzfufEuQzgNUO+LoxG4W1Qenya1oFNRl7gA8RUnuBKVa81teZXfJQaA4DFmT/+COo3Zde8FxfNAkp5LBDRyI+QyPOS4O4qNr31R3AdHisCQOsT6AspoRtBHtirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJiLwh76mWma/iaQcyYNsMSEcEL/fEsxtDbQB/IeszU=;
 b=smZ4GpsgF9n89HhSavZPhMSEDiEtCqdqxmCketzk193Bgl2SjEWRn/48nEqv1LbI0Mrfnz2H0XFl1p9wjiSWlCLxWxM2czJubi+nRi7HuRzTlUaLx6JGB0WZDa2hUakp4SR/6wKXzOlQ5yzGGcdj599rflXVG1onsiIcXDhmi1rcF5Qvm5oYX3FSSJn/HBxwhQWmA/B1OoueQSxcA92OuCvw8bwG2FweRTrglcDKGrLwh4Eqh90n6CP+BM52890VSIn5OSwVDHvqa4zYlN9WGaakqbL1D7V58QJGRCfPGafYoZ56v/bRLeLJXwCMwtGCJz0fG7c8JLNv8gGYJbZ92A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJiLwh76mWma/iaQcyYNsMSEcEL/fEsxtDbQB/IeszU=;
 b=ADkkpXoNZT55VCPLQvdJOxrxZikY5ni2N7OlPssIgJ6yuf90vaYY5AmijuVpI7yNHmhKoocrh/30yXJuDyXTvtzHXk8fPBZ0YUuahIygA3XG+ZWV99D5YZ0SQ1A1Ouj3usK9vfvmZcz3wNi9kx9F4b/SagogowbJAJxXgxb1RS0ijSFBAGMT6xZR8cjrn7+6biTAP7AWCU69z4n0vl7c9gaN5FdAlPyJENAeqeIfPNwFGhl4+LHB1K6hmsfYjMJw/e5+hE/HvWh5MOOWJ/d/Hm5u2eJzSpzAklAMv/GGFhO+OzIq2XmKGK+qtUYiqsqDEkK9Nm+1nIa//8Me4UOhXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by DU7PR04MB11236.eurprd04.prod.outlook.com (2603:10a6:10:5b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 10:41:25 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 10:41:24 +0000
From: ziniu.wang_1@nxp.com
To: laurent.pinchart@ideasonboard.com,
	ukleinek@kernel.org,
	nuno.sa@analog.com,
	lee@kernel.org
Cc: linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2] pwm: adp5585: correct mismatched pwm chip info
Date: Fri, 14 Nov 2025 18:42:50 +0800
Message-Id: <20251114104250.2080030-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR10CA0024.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::16) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|DU7PR04MB11236:EE_
X-MS-Office365-Filtering-Correlation-Id: b8dd9297-ef7c-429b-8e09-08de236a5b90
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aHlkcVd1aHV4SGtEVzJ6M2QxNTdGNFM2Ylg3YjEvMXRkbC8zckRPVXdNN3pP?=
 =?utf-8?B?Vk0vWitFVFdEV2NGTHZESjVsNE9BdE1xbitENS9DemhOQ2xDMGxCR21paXFK?=
 =?utf-8?B?V0pLaE95eFFhUHhJcWJTdjUrWEV4Zkp5U25na1h0anJCNjZub2lQeDNVWFR0?=
 =?utf-8?B?WlFieGw3MTYzZVRqR0pQSWh5bk1JSGdXWWE0VGdMdlAzUGUza1hzQVRjamNt?=
 =?utf-8?B?TjdiM1RwQUh4L1JtVU0zaVlkeHJweHJCaHVSVjVVSjJEZEZxRVJsMGFXamox?=
 =?utf-8?B?d2ZCb2Mxa3VSVnFRVHNYNnl4dDFWcTAyNkRNcTlQRjNTRk5KSW1sTktmMWE2?=
 =?utf-8?B?Z0k4VWdMaHlBaTdubUFvVWpQcUJ4cEFkUFNuT0dDR0Y2OERlMnlEN2tKRXhs?=
 =?utf-8?B?dWpWd3pOWUpzMnhkZmFzOHhQcXJ4OU5PL2FCNFE4anVhcEtYQjkrWFRZYUYz?=
 =?utf-8?B?MU9teEt0dGdwMFcvMGt3cXRyNVVwODNxT0I5TWQrU3JhekNJYnFhR2NnOC9L?=
 =?utf-8?B?K1FXRDQweDdnc3IxY2ZNZnpvclFaajBHaXRvUWh1UFJDYzVidXBLTTg3bjdY?=
 =?utf-8?B?N0lwU1hFOEtnUGF5aDNoK2FadmR3dHprYjIxODkwalNmdW5jUkQ2VjhpakFx?=
 =?utf-8?B?Tm1vaTF0dUs4UTAwbjg1N0syVHFhMXF4Y1NXZDRGcEN3aFFsZW9oRVlhdzNa?=
 =?utf-8?B?eEp4NmdUS0ZSSjVZdSswejY1ZExnaDRIRVA1R3J5NDFDMlRPaDJMOEVEZWEv?=
 =?utf-8?B?a2YvTlp4Z1pybUN2SDJUNjRyNlAxN3ZsOTA1RUJqbmZwc2U4ZlBySzBWdVBC?=
 =?utf-8?B?WXA4cHBmS2JPV3ZUaHFRY3FXQytTdWJVcE1FVTZXYnpyNzZ1N0JISjBLd0dq?=
 =?utf-8?B?NjN2bFZxdkg2SW5VS1hqM2tzZnBwM29sZER6enErb05sMENUS1VITVVLbUwx?=
 =?utf-8?B?ZkczeThyb0k3elhlRXBFQ0F4SE1sMFhlc0JSdDVHK0t6OUNSbnF3YVFPR2p5?=
 =?utf-8?B?SG9EQjRCaXlmUjgyK0xYT2kyTEVUUlM4ZGRnTG1pamhkTTdublVwSUNlVmVR?=
 =?utf-8?B?N0tMV2drN1hXRE1tYUdvRkViRUh2eFIxMjQraDBqTEtMRG9OZzlXSEZFM04w?=
 =?utf-8?B?eUJyM0cvOTBnc3M4ZTg4NFJEdVZZdk95M1ZrWkpaOTRUUkh2OVZsOXRkK1pm?=
 =?utf-8?B?KzNBazRxYnVRWGlsRWp6bHFRMXBNS0t1MnloZWloK1lSRHRGNkdqYk5vUGlu?=
 =?utf-8?B?TW11WGlqdFJvOVFUU0YwMmFZOFI5ZGw2Wm0wOUE1bU1iUHVMcmpVRzlPU08y?=
 =?utf-8?B?ZHd6K25hbWVxd3B4Qmt4cEs0YVhNWERVL2oycnYzMjVrdER6UzJTQmh3T3FQ?=
 =?utf-8?B?ekF1bDdheUVncVkzbzZHdnFMZDEzSUlLTEgrQkxlN2lIdkl5ZjB1b2ExRnNv?=
 =?utf-8?B?My9pcStaWXU5QjI4TFpzMUdUa20wOUhldUlyMUUyN1NJVHdlazh1SGpPdUZw?=
 =?utf-8?B?bEZWNUFCcXlFU200SWV3Y0NrNEk2NVZIeTBKM2xwWHNkelFvMFNhOTBmSG5i?=
 =?utf-8?B?dGk2QWMyMGN3eGNnb05uT3puV1NFWjlvSHRsMWtRZ01hTzArQm9TVHEweG5D?=
 =?utf-8?B?d2VPZ040RmY3RFdxbCtTak1wLzIzR01YUXUxTzBKa1BLTWdDalNrb0ViWUI0?=
 =?utf-8?B?elZyelRqd0JVWCsrWXNZTWwvOVhmSE5hOWowaGpobkF6c1hSSlB6SFgzV2pS?=
 =?utf-8?B?UmhqSmJOb3BSUXZPb1FTTVNYNWk5d0RhcDlUYkVkam1rV1pQaVBNcHBnNkdx?=
 =?utf-8?B?NnZEb3JsNUZBOUNZMHFZVWdvbzlJbHcwNWlXT0dBUnprL2VHTXhObkFJeGVC?=
 =?utf-8?B?Y0RyQXUyWE1rL2NlTTQvRytvMmVzdXhSRzFCRlhva3NtNWFOQzZYU1lnOWZC?=
 =?utf-8?B?WURRclFwWjlqU3ltYWZrZExtUzlzR3NLVEJBVzVqM0xRNWVxcXAvWUJJbjlX?=
 =?utf-8?B?TmxEYjhjd1BKYmg5ekorUnBDSldUVWxNWGZMQjdXQWk3VnRFbytRQTJCb29o?=
 =?utf-8?Q?fYijQh?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RmVJb1djVHZoaXV2UmpJbXMzNGtBUjFjT3ZkQ1dlZ0N3dDltajJVUHo4RG9t?=
 =?utf-8?B?VmRKR2R1Yk13QnorSDRCUnFubWlFUUhoOVlEUlVwMVV4OXVGckZCVG44QWJo?=
 =?utf-8?B?bXlVeFhOalJvQkpYenF5S2lPSVV3cHNMUnBEOFhhelZMUndFK0JMSi9OMGE5?=
 =?utf-8?B?YlBJKzcrNmVwNy9SeW5jOHdiZCs5REpxMUN5dHVsQVVDREgrOGg1eXcwZHVo?=
 =?utf-8?B?a1RVeXQzbkQ0RWlGVDZ3ekpxVFZqWnVUc05MVnVsb1ByVUNpbHlTVGJONG1V?=
 =?utf-8?B?ZTdEcFdQdjJna0gyT0VGRjdKbG9Ca3A5ZVBid2RKQlo4bmJGbzN4V0hRSTQ1?=
 =?utf-8?B?RkNWUE5JTEUyOWI4eTJ5NzczdzZzQnVlKzB5aDc5c3hMMlZ1L3ZPelQvSnh2?=
 =?utf-8?B?QWxMYUdRRTQwNDkzVFVuTG9pT2lDZjNSRHZtYzZXSk05RlNGd1BMWjZEYlVn?=
 =?utf-8?B?V1ZybTdCaXF0VHpIY1NJbVo5SFlnYUpwZUUxcEZxUGdHbFZHNVgxVVhjVUp2?=
 =?utf-8?B?ckxObDRNTDNVVEFQc0ZVMTBSd1owWjU5UGhmZTVNbjZ4dXZoUlB5Wi94SSti?=
 =?utf-8?B?Tjh5SWdKZGE3ODRia3MxcytPdEVlbys0dklOdHdKRG12bWhXdlRZSEsrWW1S?=
 =?utf-8?B?VkFCTS9iVjlzT04xY3lzYnpwWHRXUkh0dnhmQ3lvRTNZNnNSREFCeS9HVWdZ?=
 =?utf-8?B?TiswbWJUcDRibUEvRlQybXJvbXI5TlFhcitUVFZsK2pFanVHczI2ZFhOZW5E?=
 =?utf-8?B?NW5Zd2RFYWNJZmZWeTlmejliOEI3Rm1zR2JlMmxyTGU3UlA5WFllYUZIdXJU?=
 =?utf-8?B?YXgrbUYvR3B2NlpqL29PeFhlTEdRdFdyVXN5amwxdU5IdUtYZ3lVeUMrOHRt?=
 =?utf-8?B?R3NtWmo5Sm9QUE0vQUVEeDVvSlNYc2FMS1FwN1l0SGY2Y3A1VkFqTkZHUllv?=
 =?utf-8?B?WG5nS3ZMeU85K1I4bCtnNzdKaitOcitsSlRoRWRPak1TNlZ2bVVnYmNYTE56?=
 =?utf-8?B?UFJNMTh6ZWZIUzFQMVBIeHE4V3BxcDd4NjdFV004WVhDbXo4a0NYMXRERUFu?=
 =?utf-8?B?c1ZadVlNWENIQnVWY0ZWbzdzUVkva3pDeHNlZGYrU0t5RENKSjF0M05XeFl2?=
 =?utf-8?B?V1JlQkFhVy9IR3dTOXRLLzZDbHZ4OUozMkE4Tk4ycEhhS0pnSUs5M0ZzeFBv?=
 =?utf-8?B?ckdKVnBtV2NUVXRBUVFHQzNBOTdZRDZMb3BZZlBrQU5HNVp0RllBU0kyVjdU?=
 =?utf-8?B?RFY2dWhqUTJyQnB3QXBxK1pUdjZ6N00rWmdYcDM0NHdCclJnZGduRDkwU3pR?=
 =?utf-8?B?a3FPTlpUVktTa0lHNkxRcWtxT1JwMUEzN3B0WFViZlN2aloxU2ZTQVFnckpQ?=
 =?utf-8?B?bkxqTjkzZXRLTHA4cytFTXppS0xjL25aUTg1anJ1ODduYjU5YytLQkdnL1dq?=
 =?utf-8?B?YzBSOVNHYkwrNHdNeEZXanNnMG1lcVplbG1KWmF4NysvZVRicWdhSmpneUpz?=
 =?utf-8?B?WlNnOCtZUHlva0dhZm1rNXRwbkdlS0JjajlqWHhVb3ZsWFVZR0ZVUDI5R29X?=
 =?utf-8?B?SERVWGtDY3I3QTkxaUUzdFdIaFNrWURvNFZuYUxkS3dDWVF5am5wQ1BWNk1G?=
 =?utf-8?B?bWNSVEwxTEtkQWEzY2VRQ2grcUR1ZVVTc2x0eTJiaStDbkVOTkFqRlJ5ckQ5?=
 =?utf-8?B?L3RvdVZzMkozbnpEMzNnVXpXNGwyVUpmdXBVNDhPUjVSQmM5cVA5S2Y5aE1B?=
 =?utf-8?B?aHdIU0htRG5jd2lmbDBpb1V4OFVCSkRSY3lQSWIxT1dXN0Rpb1c2L3pGKzBP?=
 =?utf-8?B?K21Vam5DTXBDTy8yUEFMbi9oMXNCaSt1NGJaM2dsSkhWVFlEeVVicVR0RWFt?=
 =?utf-8?B?bXJXYm9nR1ZnRnN3WEloMzFKWHFGdDdVUHdBRHplWGZoMExJcDBGVGxBVGxX?=
 =?utf-8?B?Ri8xYlBQakYzNUk5NHBEdS95RHlmN3l5NS9DQnJUWlEzM2JHcnQyZUZPYkNV?=
 =?utf-8?B?YnFIZmNEc2dyWDExdkJXeUFnU1NLdVAwUmdEcFlwd29MYzZua09maXZSVlYy?=
 =?utf-8?B?ak9FbDV6SXV6SFJWR3lReGdiWDlwUkQwajNoOEZYN09ZdmhDVzJRQ2I2U3dG?=
 =?utf-8?Q?J/QpFDKbJ/vC0ZRhDzE6JfEfH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dd9297-ef7c-429b-8e09-08de236a5b90
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 10:41:24.6916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w5DyDUbcUHUsOebViaD7AuAQkk166Ql3EmiV71Mh9YpnUMgRy7vtpB1tpupjqchbDMVgAiQiL8QomKmxXdnn5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11236

From: Luke Wang <ziniu.wang_1@nxp.com>

The register addresses of ADP5585 and ADP5589 are swapped.

Fixes: 75024f97e82e ("pwm: adp5585: add support for adp5589")

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
Tested-by: Liu Ying <victor.liu@nxp.com>
Acked-by: Nuno Sá <nuno.sa@analog.com>
---
v2: amend commit message
---
 drivers/pwm/pwm-adp5585.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
index dc2860979e24..806f8d79b0d7 100644
--- a/drivers/pwm/pwm-adp5585.c
+++ b/drivers/pwm/pwm-adp5585.c
@@ -190,13 +190,13 @@ static int adp5585_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct adp5585_pwm_chip adp5589_pwm_chip_info = {
+static const struct adp5585_pwm_chip adp5585_pwm_chip_info = {
 	.pwm_cfg = ADP5585_PWM_CFG,
 	.pwm_offt_low = ADP5585_PWM_OFFT_LOW,
 	.pwm_ont_low = ADP5585_PWM_ONT_LOW,
 };
 
-static const struct adp5585_pwm_chip adp5585_pwm_chip_info = {
+static const struct adp5585_pwm_chip adp5589_pwm_chip_info = {
 	.pwm_cfg = ADP5589_PWM_CFG,
 	.pwm_offt_low = ADP5589_PWM_OFFT_LOW,
 	.pwm_ont_low = ADP5589_PWM_ONT_LOW,
-- 
2.34.1



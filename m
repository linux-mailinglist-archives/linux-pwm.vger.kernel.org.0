Return-Path: <linux-pwm+bounces-8242-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ANBGPxvs2kEWQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8242-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 03:01:32 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C3327C73D
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 03:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA3A13018C29
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Mar 2026 02:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9663090F5;
	Fri, 13 Mar 2026 02:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="zRJt8Nze"
X-Original-To: linux-pwm@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022108.outbound.protection.outlook.com [40.107.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DF91D6195;
	Fri, 13 Mar 2026 02:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773367287; cv=fail; b=vGhzRkihuUKn+C0tCebcprh/Nf2ycS/biavkh5Zk8IakyPthMiHRHeTy5iIFIpzMwUewNxRbGfpH61Hd7Di7Sa1+KK6AgKpLzrdSmFadIKZ+e8vfS9RrmOfACYRxO9fr++rISmm1pIWlAf3VE0znPKUG7ALAvkOzEe+4eN6Gs/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773367287; c=relaxed/simple;
	bh=QagL4SmZdGVnvodpbH9MS4nMnwXPCmuPB9PN2qggI2c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VsYMd8QfdeQyh+liT4zckX9aQ55zPOw56PsCqf9xU449g9g/kvBRAtPhroqFMEPx/j1fc1VtpMG7ikFoQAs6D3oXHASHs/6HVGV/zqGjEwMlELJnuej2QkB2nVp18ih5TAsLqr0WiLOCfFI1ODdZdqDw9wbqRNI8gCI0LS/eNxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=zRJt8Nze; arc=fail smtp.client-ip=40.107.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUjHZOfC2BXNq+gmfVfbAdZtaz2de3aAT5H+xZovdOeKP4IhMgFLcYW5MnRodIU3Z2tB8Vi4i+SQAjSq2ayfhPC95hurc1Rn+9kROdcpXdWYzVs2cwgJnmgaeZJ0BHjw+2yHjt3qvfTOIs/qrIUsei0cT5rVskEBwePLSGUh2nHCQqU3eX2sHmPLwd8e12mGHrhmnnghi/UiW9g98NpA1BXoiGHBdr9XDYHv+a3OTw+kzm8AwoxNXsb95rgx3ZtmmQe947Gtqj5qxc7hYqJY3LWQVScWun5tssbyMl/oA2h6XpRp5oMtpnoe/EmEn7vDvyeCzgGlpy4WQx8pf/q/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBxBlyx0N1cd+t2BjbB6N4ZaHrC06C38R/k6Oft7rhg=;
 b=m+ADtXc0KAIZpgHrxxP5i9+3l13C0v4CBZQsZsCTkHIcKC55esOBUL7QJJmSffNicspdeDYx0G6kLAppR6vTdH46L5JesNd5eELvK0OcrIfBEHRfMV/SJx/cbmcTb8x4XfkSMVGTi2D87axoDyBdeefZAwpIoSAMSPxJ8BDzn6X0NYV2lh19pdoX6UFkNiehIqp+tMXbubn5pWohdC41t7OhbpRMHelQQM6HKEk/VX9gtfetYsixafAp+D3koOwZ45FxNmAocixIb85PxPKQgnGUvZb4/+qdVI460Xn1RXfhUYRLHYnj/R1Jio13Ig6TIRYTJY6A+e3Xl9tm99kTmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBxBlyx0N1cd+t2BjbB6N4ZaHrC06C38R/k6Oft7rhg=;
 b=zRJt8Nze6yRWGMaDXGrsAJuGGMiIZg0l2SKxKKdnQfIHDGKBLvjRtNXuki865o3msBMt9iGpthnzkZA/SdNxt/xlslIbWHM9QTuGpcTBKYavQrvhL5M4iWMeGzybUGuDZWqbU+nFraFrlgCjxhAWU5Xz+snudNRmzNfZV7mHrAYaBp3lB4FkDT2hnXHWeXLh0CnRO8X4kVNHhXaAK5UyZSFKl734iKLLyh8Q6q+eVVRD20WCt1aIKHT2TX6z+1BhXRSMZeX2P00PE9jh4ih0V42lPaKwQqsG8M0mZ/wNjNqWF3uVlmraZx/ZyykqSBKo6+IqvjI9i1RC1BaPQWA5gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR03MB7432.apcprd03.prod.outlook.com (2603:1096:820:e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 02:01:22 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%3]) with mapi id 15.20.9700.010; Fri, 13 Mar 2026
 02:01:22 +0000
Message-ID: <34177784-dc09-4056-b2ba-abb9a3ec994d@amlogic.com>
Date: Fri, 13 Mar 2026 10:01:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: pwm: amlogic: Document A4 A5 and T7 PWM
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260312-pwm_binding-v1-1-515cb65add98@amlogic.com>
 <20260312-perfume-afternoon-da62000ff87c@spud>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20260312-perfume-afternoon-da62000ff87c@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0265.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::17) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KL1PR03MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: 494ff879-4174-4991-8b2f-08de80a46c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	fohvbrL7zgevrg4MH3VKzS8gZkkI6sZjb2fOI61b6/tNrJgYTv9SYB8S48QE6yyKg+No+tlaA/p4E8HvrpyVJ0mfPRAu/juFkwUlsUYqkITIVbTi8etX5aTqWZOzXpmuMYPfzv4jBbu+tuzesa7MgiAAGMQ0Rp81byV3KaE2iUqKek04pe9Z3AaAIpFo+EaLKVxrQCTxjznapymDx7xcVoI24YzwGIboNXtbKC44Ngj+MkXxuJaZXD+67Li9YLb6QCeSPsIfim4M8BLWvuFnGl/OsTZLnsuv/Dez5aW1t8UcL9suta8E/xkNW2Otk8y/iz1Yn6FmaxE/zussQpOsjyRAxNmLBYa+H0DTiNX7rJrP4gVgeQrb+n9oYjVg7fRJILlMmZen7DU/frmoxxaqr5nQCYIYlm4aFtyHQCdjQCHzKGUU8f3EciT9ptqy9YcoQ8804wVXTlHoli2ij81CJ2CfxVBwYFF7IKstfzZxp7Kyw1F2dhGvZC5uI5ASd0AI0BTTwJJlgvDIDVCZlj7NchsdBwWd96zUH9fSWJoVgrzYUdgznIFUVTSlRm1H/Q7Iq7ExIC6e3ktoj8oeDUkTnk/9SgSMSCmoocJByJT1hTPvdPYM9PLkVhm+gSEZBEyKC+RMc7AaoFUNWR5f/llF6JL7vr0xHuahIoIh8w3aD9GbAIvhSvtMXHgdiLSfcbgC7I43NaFmHA+j/7lq2VNrlKMuszquQVoNt9tlY6QnuM4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkpDRXBSUVduQm5Sa09id3dJdGNscFRhMjZBcEV6bCtPOE1vYnRIN1FIMzZw?=
 =?utf-8?B?OWtlZ09kZDNHMk5vbVk3Nll4TFEzaVZzamNJa3lBMlliaURVWkJ1ZWU1S08v?=
 =?utf-8?B?c0lsL3VrOFprYzJQUlFreUFsYU55b1FkUWt5UmdrR3JmVFFLVGZTQW41bnZU?=
 =?utf-8?B?ZURUZUdPb0gxdlVjQXMxcUowdnVyajlWcnp5SlFXMC9STHJrd2plZ2N5b3B3?=
 =?utf-8?B?MHJ5SEpHQk1LT0w3dzZlemU2dk9QUHBJeXhhYVNFT2MrL3VrWUZ6RnptQ2RQ?=
 =?utf-8?B?aDBSVGpUZEE0THpyODBTYndDdDJJMWtBWVc0b2FzWVJpdWhDRS9qOE9wZG5M?=
 =?utf-8?B?SDZTSGJlUTVLYjl5YmVwc2FkUXZwN0libWhIOG92QW9IaFZ0bko3bUJ1cVZm?=
 =?utf-8?B?RjlBdytJaUY0QmdIYTJrL2UxUEZIdDJJRVRBQnl1M1NHcEFnWVF4ckUyNlZM?=
 =?utf-8?B?b2I0Q2wreDhYS2U2bWxiVGFZWkVqTmdRbE9xdi9WOUtjdVBWZWorbEVrdGw2?=
 =?utf-8?B?clE5TjE0bWdaZXpETHVmV3ROVVB5ZjFtNTI5ZERkcUNHSnZQVFRMTTJJZW1M?=
 =?utf-8?B?dVZ1R09rdHhVOHJxbWNKSzh5Q1I4SHBiNmpOSm9oYW9lNy9wSXl1d093eVJK?=
 =?utf-8?B?dVVLVkd6OGhDQ2pqNFhBWnk1anJad2pKM1dBTVcxajBoRk9sNjdURTBQR1ZM?=
 =?utf-8?B?MVZLeFl6c3JxT3VJNTdnSTFJZ3V0eExtMTRqWXFCaDdOWFJJTjhGdjh3Q25B?=
 =?utf-8?B?QUxtZGhLS2Joc1ZwQjc0dUlpSnhybWREQi9Ub29nYnhXSTVyUFpGbmJLM2ta?=
 =?utf-8?B?cVZHUkNRVjZPV2kvZThvYkpNdlhQZW1WQ0wwZzB0WlMzakV1YVdyNndWK3Jt?=
 =?utf-8?B?RkpQZjVYZWJGRytySlM3cmRESTBkZWFZd0pmUlVIVER6Y0gxRC9ENDU1SVpl?=
 =?utf-8?B?ZWJnekd6OGI4cVZhcVdDekdWTTU1aThzeTk2ZmVuU3h5bTNlWDFkUTdIUDBF?=
 =?utf-8?B?bHFFL01qL1RXK0M0RDc2cDdpc3V5R3hqMHBsY2NpS0dNNlBpQmMvNXlKOXlj?=
 =?utf-8?B?UVBtMUlKRFM4VGcyQk9kNWVTZC9TTlVBMVI4dkFnL2lsdk8rbUc5YXN6STk2?=
 =?utf-8?B?QUVleXExWDc0N05IZ1FlSDRNbG0xY1VNS1VxYUczZmxOTmE3MS9ISGNEQ2Nr?=
 =?utf-8?B?eEk4eVZrQWxqSnNuQ3BtaHBzc0o0Vzd3S3FLVldCWi9kZ2R4dWpXTXk0YXBv?=
 =?utf-8?B?cWR2eGdYaEdjUGNMY1B5SVo2K29ZSUdFTmpsT1RSYzNlczI3eUl2WTVGWG9V?=
 =?utf-8?B?TUo4Vk9WdW4zRjd3a0xiUStRZUhNQU90QUEwcFlaSlAwWFBTSnZPREd0b2o2?=
 =?utf-8?B?MnVjZlRLN2RGdEN5a3ZuQjdTMTNRQzJCb284eW91Wjd1YkNUeHJZZFBTYit6?=
 =?utf-8?B?eEh0OWdIdnFOb1FiZkVvQjg2K2VEMDZMd1MyNzU5UEUydyt2MjB4cjJLMGdy?=
 =?utf-8?B?UE1ReXR2WjFobVR0dkYxYTB3MTFlYjZEUFBNMmpzSW5VT0N6RzcvYXFtUG1t?=
 =?utf-8?B?dzBiME5CLzJXRVlDVmQ0RFJ0aXhlaCsrZmVLa1FUL2V3NmNKcEw1aTZQbVJW?=
 =?utf-8?B?VE9TazMzRXRudHdjTGtQWnErUUlNZmFPbmNGdUxaTUtyTXluTkZkeHQxZFNF?=
 =?utf-8?B?L3pjRGg4elZhdWJnYTg0NDhYVWZBZk9vYmlQWGpFU3Zta3laQm45MVZaZnJR?=
 =?utf-8?B?LzBQOUtLRzNWRHZzSG9Bd1hTcTBwNVFMN0lkeEFaSjJwTEthSE1Oa2k2TU91?=
 =?utf-8?B?NG5BbDlpa1RHTm9TMitMcU1Pcy9SR1lIaUNvSk9iREJ5Sm5mNk1QZ29WR2Vi?=
 =?utf-8?B?Q04wQUhsZExmOWVLUVBmK0VJeTdSQnFNa2R4SzJZZGpVVE5JbjJ6ejVORUZw?=
 =?utf-8?B?WEhmMG1ZMTRzeitZKzA5RjQySXN0R01VM2VaYnhTUU9TaWhaVlRRdEkveGs3?=
 =?utf-8?B?aE10clFBcllFUGdFVS82ZXQ1eGlmeWU1OU5yNExHQmVzRWk0V29PSVpiUkt2?=
 =?utf-8?B?MDNsU0ZZM2crd0plME8zMUlBNkJSSnQvdEFKM1ZaQjFIdlloTklKSXJBZ0lX?=
 =?utf-8?B?U3RXclhSMjVwT1FLeGV3MGZYU2hxUXZyNWoxajNwSEtlVEJ3c01zUEZ5NmVL?=
 =?utf-8?B?NUlBU0xOVVhGNi84bjJlSVFFZFppMmZUdHpsNTI3a29FbG42MmhvaU1NRXJV?=
 =?utf-8?B?a0g2c2pHSzloQmVMdnA0WHBLWjdVYk96M0Z2V0pCYjJTWXVzc083ZXJNUTFk?=
 =?utf-8?B?SUgwK1pPSmRHSEE5a3Jqam11K28vd0JsSzdlZVNlOFJ4dzY5Q2Vxdz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494ff879-4174-4991-8b2f-08de80a46c8d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 02:01:22.0004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GM8HoNZ0AEVPMibkXis+GgnOxEX/lhWjMdLyFfza9vsfH+k0pI4PQuxG72Q/nHth3ufsesgqn0UwaodXBYozsR8RGb+hehiAG74yHxK1Vfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7432
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amlogic.com:+];
	TAGGED_FROM(0.00)[bounces-8242-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D1C3327C73D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Connor,
    Thanks for your review.

On 2026/3/13 01:54, Conor Dooley wrote:
> Subject:
> Re: [PATCH] dt-bindings: pwm: amlogic: Document A4 A5 and T7 PWM
> From:
> Conor Dooley <conor@kernel.org>
> Date:
> 2026/3/13 01:54
> 
> To:
> xianwei.zhao@amlogic.com
> CC:
> Uwe Kleine-König <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>, 
> Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley 
> <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
> linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
> linux-kernel@vger.kernel.org
> 
> 
> 
> On Thu, Mar 12, 2026 at 03:10:28AM +0000, Xianwei Zhao via B4 Relay wrote:
>> From: Xianwei Zhao<xianwei.zhao@amlogic.com>
>>
>> Document amlogic,a4-pwm amlogic,a5-pwm and amlogic,t7-pwm
>> compatible, which falls back to the meson-s4-pwm group.
>>
>> Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
>> ---
>> After the clock module is merged, the PWM node will be submitted
>> together with the nodes of other modules. For now, we submit the
>> PWM DT binding first.
> I dunno what you mean by this.
> Are you talking about submitting the dts user of these compatibles?
> 

Yes. Previously, I submitted the module DTS node and its binding together.
However, this time the submission involves DTS nodes for multiple devices.
Since DT bindings and DTS changes belong to different code trees, they 
will be submitted separately.
This note is provided to clarify the reason for the separate submissions.

> patch is
> Acked-by: Conor Dooley<conor.dooley@microchip.com>
> 
> Cheers,
> Conor.
> 
> pw-bot: not-applicable
> 
>>   Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> index cc3ebd4deeb6..c337d85da40f 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> @@ -39,7 +39,10 @@ properties:
>>             - amlogic,meson-s4-pwm
>>         - items:
>>             - enum:
>> +              - amlogic,a4-pwm
>> +              - amlogic,a5-pwm
>>                 - amlogic,c3-pwm
>> +              - amlogic,t7-pwm
>>                 - amlogic,meson-a1-pwm
>>             - const: amlogic,meson-s4-pwm
>>         - items:
>>
>> ---
>> base-commit: e3194dfb772304a1b7ca3bcfccacefec3468b7bf
>> change-id: 20260312-pwm_binding-ae847cd0c70f
>>
>> Best regards,
>> -- 
>> Xianwei Zhao<xianwei.zhao@amlogic.com>
>>
>>


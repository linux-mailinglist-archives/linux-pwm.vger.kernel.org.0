Return-Path: <linux-pwm+bounces-9615-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hQQfDfHOTGpKqAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9615-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Jul 2026 12:03:29 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD9C71A16C
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Jul 2026 12:03:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amlogic.com header.s=selector1 header.b=pThxNAHs;
	dmarc=pass (policy=quarantine) header.from=amlogic.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9615-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9615-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAC9A312FB9A
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jul 2026 09:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7733D88E3;
	Tue,  7 Jul 2026 09:57:54 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023082.outbound.protection.outlook.com [52.101.127.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C636830DD2F;
	Tue,  7 Jul 2026 09:57:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418274; cv=fail; b=uZk0MGKJRhv7bt+MaaUkYR1awZzoR13iy3pz25y5+CVUteo/bHGicjXUJ3GAuIIhPMA6tdz43f/88RpnvXs9/flhGqM8AU3YnhRlAk9XcM39hSDcdv7Tk+m35GWs6ci5NYYZYF0IUL6A6o4grhCNybqSe3Wh6CHTm8K6/WRqVVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418274; c=relaxed/simple;
	bh=hLROzxoIn/9aA5K3B+z4V7SyNjhH+E37kIRsVdQe+Ow=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R8IondL/Tke5ECO+d29XUB/xFqNh+zbyUTSQm+RrMLB0BEMGfQ2kAMM/7TzRiMP7ZVhBTpq9ktN9P5dbMMQgR8eOu9hUaUvSdVElujWeAVWZpYyTY8egat6p8Cw0EdA3q0yCaIworoBIBiToaPILTfrXq7dosUZ6d1Op3oZ/9bM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=pThxNAHs; arc=fail smtp.client-ip=52.101.127.82
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pt5lhwRmdYZLMYHLdnTDOxRl74R5F5y5n5XYZIbcp6J2RLPLoY1YZAXWFPLecjlLM9pKCebw0QsxrX3p2jwTjn098nhxPIl5qeh2KL0dIE7cMloqtNRiOWdEwkplF2Fsph2Vivx9P0dbESCrEFlmIMWSmfGN7YS3xRge+bp60BsRaoJpTLkDo111vZCxA3iTO6HhmJa4QJb4Fs75eXgzMKskYoHV+Q9pyUg04qsYePJ3l5vPA6qQzIabeX71MZR4ADwRgiiRtlMi+d6DZWR3+fs+b154zaQ2qc4rfWEkYRUXqMRMefKftRRuflqcBhD9Xjph/gT0Rd4ApvIOfN+OXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qE+rW76cn3sDLX/D9ZZD30jDNJ3D8l046pv+8Eie1AI=;
 b=V+gHQUp99da6SSxQswqPbknMNm+JE6njQ6ptxs63ERRPl+xR1lnIS0+Vu5qiU8HG4oTNO1BReydEvWRWZz4c03O0qr4pzSaFKc5p4aywiJCm7vzbT+WvlaFyM5DzWxT7hvTfJNbyfl/PdEXMYHnmojhjRAqJbt/WS9CAPzqWKZVTOBDjchDP7yesAXYMvPEpyTdirGjuQ2bGTb5F5w+k3YoRi4WaFijIsLYrbkJAeekqAgBubdADVDNTuIPi8FVxmm0ST1KRnNg8Uue65bz6HfIZAm5DDSroG+QITUVdxHlPXob9pCm47o2mp3etkFIcjYRh3XD/b2Q8QzdJmuxhdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE+rW76cn3sDLX/D9ZZD30jDNJ3D8l046pv+8Eie1AI=;
 b=pThxNAHsy8cVJD/Ynclyjq2Ran8EU/gybyjR4Zv7y7rGU+TfxpzgCk06wI/7VSJbAOiWChdBpc5TVhacBfbq2u+A+4SJN318AgI+q7JJpeET7N0JNisnch3hipApuimH6TYoyf/bBW+H5ZHKgn1T8VC8Z0LJieTxVxZrmP4LB6PTrW+QeUSL7K33ks8umYruUgvYVlBhyuM3ZbKqJRd5CJkSUilGub/WSj6QElWXbkN7TAPzUs2hLayAW3xniHdCkcW6K5UhbzavkHyKG4VwYMrgTlE248d5dSEgpJBlw8WVam13Sgpb2EoHRrxw5NnxWVih4sJNInXJnIUFST3ibg==
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by OSNPR03MB10133.apcprd03.prod.outlook.com (2603:1096:604:49f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 09:57:49 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::78d4:9dee:2e32:d1e4%3]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 09:57:49 +0000
Message-ID: <bd77ea7a-966a-4127-8e57-6be1afe4f379@amlogic.com>
Date: Tue, 7 Jul 2026 17:57:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Add PWM support Amlogic S7 S7D S6
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, Junyi Zhao <junyi.zhao@amlogic.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260521-s6-s7-pwm-v3-0-57b073fbafef@amlogic.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20260521-s6-s7-pwm-v3-0-57b073fbafef@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|OSNPR03MB10133:EE_
X-MS-Office365-Filtering-Correlation-Id: fffaaa43-48a3-41e4-7217-08dedc0e3400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|18002099003|22082099003|5023799004|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	XzSqQti4149kiE75NyNwNIzPr8BKq2v006X3r4cB9xTvnvhmU4ZtxN350nxSUiFPHvOHQSXe8zzSMKtlmN8CbXb5KnjiIzbsyU3YvNydDRPGrI0r/LRmcmP/XamioSmeqGGaWdp4DSXMcDknGxGHCazus4uUR3jzmPdhmHO8RxTLF2q8aOL3N6hOyt7ZfgK8D46Cf/m5HfhkjPVzG8/lcOh5IKSJvDhERQp3dkbE90EQagDeSnKlOzvrBXkSx+fYvofx75nx0VVKpEe4aycNZqtt+DEhhRY+wZtSao6gFySBALKztE0lhBe4xFc8Y5NoH8Toz7HvUKoyM6R6rUeH+0SIAjs+3kAqSzx8bUvNmsVP/gJgVzMfhyc9LiRyXwm/ttFirar4vHSdbqo17SFbsAJrcRKa3/gbqbFyqZNZmJ9Pr5vPDwOniZVKhXrXvgLFLbt12x3yip0P8LUAMlnxD9Wvlxf0uvN1FM+G1H7lzrS3Y/BN1B2a9mnvJ8RUsV0P76zjB0A+TqMOOQykLpLU5G3bDppjGoWcVE3KT9GGcryisIECyWEAefgSihin2mvxjWueoAHfVWJoLN8yYm8DI/GPVGkSJmQB1ztFOVp+GUroDx2bHn4YVOB94+qRpzu3mChf7DJTWPE9zVwXV3iIhFmc+NHSeelblkZFsOR5n3w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a25CUVdSZ0U4STFoRzlBM0E5dW4rTlRHM3IrcU5zRXFoTE9Ga3NMTUl3RmFD?=
 =?utf-8?B?U2dNN0dnLytYVEVBL21CcHpKQkhiOWk2Y3dqSFFMQk1UVE1CQ2UzYkZ3dFk5?=
 =?utf-8?B?Z3YvSjJ3YlNwVUZBdytLdWVWQjliaFU0QTJ5L3hseE5ubXFHK3ROeXZCZlZ2?=
 =?utf-8?B?eWh6VHhPTUFQSitQN3NqWTZBUE04SXgxK2dyL1Y4WmJNYnQzS1lKNGRCbHBy?=
 =?utf-8?B?TG5JeGZJTytCcnMyK3hWMm9SMkplTE1SeGdRUllRTGZ3RjVIa0kwK1ZFcVJS?=
 =?utf-8?B?SDJ2V1BUR0c5U2M1aTkzWHF5YUhqZ3RPNEdCZEZEdVR6Mjd0bk1vT3RMb1M3?=
 =?utf-8?B?RG42MWpWL2JVOTZlOTRVdXJ6Z2grUGlNbGlUbTQwdnpNWml1ZmRSbGVqeUhB?=
 =?utf-8?B?VGk2NVJ3SlBtQWovT2tiWTVxczFWd1lqZlVQRVlPR0NvL1dQY3Y2Y0trZW9l?=
 =?utf-8?B?U1dER0JVKzhWSG0vZVNibGkrei8xRTlnZjJBNUpPcUNSb3BPZC9kWThtbUdp?=
 =?utf-8?B?VlZJY00weEcxY3UwOTlIN3BzWlJ3WjJLc1d1UDgwc2QwSElWdkJiOTF4dVNH?=
 =?utf-8?B?YXE2U0hiWWtwL3pzNU05Y092RlBJUk82RTEwL2FKVFB1YUxYZCtLWjdZdURi?=
 =?utf-8?B?S2t2dHhIRFNKYTlpMFdFOFN0NEJoM3ZCR3RDNXNUYy92ZW5PalVhanVTQUhB?=
 =?utf-8?B?VW1WTTd3WkVWd00xSEFLRVhBRUI5QU0xRjRHR01sNW8zaGxSNDZxYjlad3pV?=
 =?utf-8?B?OWlMWGJjdGt5T3d0bWlxRUlMMFUzYmxtb2FHakZPczRYbTlJSTF5YnU5Z3FJ?=
 =?utf-8?B?dnFzYzBuL0NSRjV0S29TbzJFTnRMclNkS1h4aE90blJ2SnEwMHlpTFkzNjNy?=
 =?utf-8?B?b0VpS2xZNnhWd0QvN0k5VmowNDVFb09oU2pSZ2E1L0gvQk1oRlNPbkNzQVhS?=
 =?utf-8?B?UkZSM21oaFRvOVlrS0VoLzkrRFk4YXZ3NVVLQzRtcUFVUCtDbXJ5S1JwYmI0?=
 =?utf-8?B?eHlreUpIVS90L2p3MEIwcEw1aEl2T0IrRDNFSEs2b1R5TXJXaDdHUjNzTzVM?=
 =?utf-8?B?YVMvOTRMRkwxYmdwLzRBVFhnRkgvN3NMUC9qZzJRNklsRlk4RUxtOHoyMXdm?=
 =?utf-8?B?cXNacGVhYmYzMUYxUERrYkM3TUxQdXo3UzZQU1BJdFp1amxxcUJZeXg4Vndx?=
 =?utf-8?B?R0NkNjVuVDQwQmJOWmpHaGY5VytnelRjS2R6a3dMUzVKU2ZGcVRZdGlGSmxs?=
 =?utf-8?B?Rkh1NWhXS1lKZzN6OGV0THpIWlJYa0x5M2RsenhxN3g1WHJOMllhVmRxRjY1?=
 =?utf-8?B?d21BTG1tbTBJd1Z2TWVZMU5FTVNvR2JON0ZvL21WM1h5VGU0U3FUamFYbzQ4?=
 =?utf-8?B?YzBKTDdpVk1KZHNzZHpUMXdwNTRhbHBNWmh6VVNJdFcxYzVuRkpsOVNObXJE?=
 =?utf-8?B?OXg1dnJCRVl6UTVmR3JoZmdtUXR5TUt5TlBwNm56aFFuRVAwQ2MyaUthMGFE?=
 =?utf-8?B?RkpTMmdxbytROWxEYVIyVEdCUGFaa2Z5dW4wSXVQS2RzY045aWw5NXFVYmV1?=
 =?utf-8?B?NWtNeGdRL1o4OGRXRm9jdU4wNWZuU3FaVGd5WlRZNDZJTm9pVC9hNlRqT0l2?=
 =?utf-8?B?QVVRR25OcGg0SGxhWnVDL21NdHhKbGI1cHVybnE1eFlRL3hKb2hOZ2pYbEZu?=
 =?utf-8?B?alBKaThBT1N6MzJxUE1DbTNNS0d6TVEzbmFYL2pGeVhDeE1xeGhTYkE0cUVF?=
 =?utf-8?B?aE1OUEpETGswaENWVitoU3FVZUZia3JqdnhWdUR2ZzJuK0hYdi9SOGY1a21o?=
 =?utf-8?B?MGNhdmw2dkE5R25FZ0lOWkZJUmlmeTlWN3N0d1VlK01nYXJjNXg2UlVsN2ZD?=
 =?utf-8?B?bDVVdW5vU00vbU9WRWtjcmM2dGUxcHJwUFZZQnJkeXJKTk9zc3ZwbWJkQ0hY?=
 =?utf-8?B?L2FkWGdhVDlvRnNyQVpuQ3lxVVpnenl3cXhTQ21uWTJZbVpibURKeW4ra1A0?=
 =?utf-8?B?RGxWWnFDVmo3cHhldE1pbVhJa0ZyZUYzWGRDSkpWT1VoU2Nzc0JKUm9pWUNN?=
 =?utf-8?B?Y1lWL1FuOVZXRkFwQm5WYUIyM3pZTlkvaWkwYjlVOEhKN09zRnZCTVZGWDNn?=
 =?utf-8?B?d0JSSVhVK0hzUVIvRTZ5Wm1oZ0piS0ZoU05NeFR1eWpIanVsa0Z6c2I0a1cr?=
 =?utf-8?B?VmFnNHZhN3RkRTJQbTNESWVLemxQWSs4YVdqNm5BZWN4SkgwVlVybkorcFgz?=
 =?utf-8?B?S04rS2Jlblo3MnU5WG5TRWJhaEhBMjJSZXdDdUxoQ0VWVUE0QjQ4Tnpwckds?=
 =?utf-8?B?MS9jMHRlZHJKTFQvNXpqRmI0RXNQSFFCbERwTlFia0F6TWZ5azU4dz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffaaa43-48a3-41e4-7217-08dedc0e3400
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 09:57:49.5743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcS79i61PqgfcdaWON70TAyraq+upPz+opuUXrYhVtnj2u2fI3HbMFyoYMJAHrycguYnuLmIKK2ebfWCSkzGNs+6RRp6fQTfZMo7bxiJx08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR03MB10133
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9615-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,baylibre.com,googlemail.com];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:hkallweit1@gmail.com,m:neil.armstrong@linaro.org,m:khilman@baylibre.com,m:jbrunet@baylibre.com,m:martin.blumenstingl@googlemail.com,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-amlogic@lists.infradead.org,m:junyi.zhao@amlogic.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:martinblumenstingl@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xianwei.zhao@amlogic.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amlogic.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xianwei.zhao@amlogic.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,amlogic.com:from_mime,amlogic.com:email,amlogic.com:mid,amlogic.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BD9C71A16C

Hi Uwe,
    Gentle ping. I'd appreciate it if you could take another look when 
you have time.

On 2026/5/21 16:26, Xianwei Zhao via B4 Relay wrote:
> Add bindings and driver support Amlogic S7/S7D/S6 SoCs.
> 
> Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
> ---
> Changes in v3:
> - Use npwm instead of single_pwm in priv_data and format adjustments.
> - Link to v2:https://lore.kernel.org/r/20260402-s6-s7-pwm-v2-0-657dce040956@amlogic.com
> 
> Changes in v2:
> - Simpler s7 clock desc, and drop the example in bindings.
> - Make minor changes to probe based on Martin's suggestion.
> - Link to v1:https://lore.kernel.org/r/20260326-s6-s7-pwm-v1-0-67e2f72b98bc@amlogic.com
> 
> ---
> Junyi Zhao (1):
>        dt-bindings: pwm: amlogic: Add new bindings for S6 S7 S7D
> 
> Xianwei Zhao (1):
>        pwm: meson: Add support for Amlogic S7
> 
>   .../devicetree/bindings/pwm/pwm-amlogic.yaml       | 19 ++++++++++
>   drivers/pwm/pwm-meson.c                            | 41 ++++++++++++++++++++--
>   2 files changed, 57 insertions(+), 3 deletions(-)
> ---
> base-commit: b1385d0c7b7c633e55adcf4a7c1ef46c43a84a4a
> change-id: 20260325-s6-s7-pwm-281658b88736
> 
> Best regards,
> --
> Xianwei Zhao<xianwei.zhao@amlogic.com>


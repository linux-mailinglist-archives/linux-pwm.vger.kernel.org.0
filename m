Return-Path: <linux-pwm+bounces-5578-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF796A940D7
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 03:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A58460D3D
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Apr 2025 01:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E934978F58;
	Sat, 19 Apr 2025 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DN4ydWfJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010008.outbound.protection.outlook.com [52.103.67.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F511C6BE;
	Sat, 19 Apr 2025 01:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745026040; cv=fail; b=nTlATNBu58Brdl1yGNaVAj9QU8mo8UGokZdlaXuvhqEjx9qWZtpEsxNPw88Y6LDvL1a2WTUXVNNrqA5DQq+TtucMYrVXNiUeu1OINFV23Xn8W2FOdQtUcdsY7T4v4xa/vGaJDeO5pG9gUFCfvy5QnmiJCwyje+xzG4VzidjaX4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745026040; c=relaxed/simple;
	bh=NkM4+3yaiLEQFNd8n5axqkPqg2MXpgHw/4Oo365T4gA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UDiNay5y938BIW6wv9sy7DHhWuXfZJy1JRXrSjhOJ02n0yyNbXdhfbZeI5l0+GftpuQpuaFkjfXC1Jc7pVmGH7WqJ6OB2DgL+TzgSgogZ26/+aDQ9Bx9+vVEQvRB7HZqlyXmfxQKA8tBhsY5+uLQwZ74dFi60biEh3NZiLau2Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DN4ydWfJ; arc=fail smtp.client-ip=52.103.67.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPX8dy0YCfk3SCbj/Otv+mm4TABKSw4lutDLSrXH7W+JTvk/PuQMu00N2lUBvwwYuWgIS7J80UYZt6NVYK/Ol0Y2kbo0yPkuUlhmD/1rFRkfFhYX650ZaV6nSHMkvzfwGVPyZty8QXW1PwvNhjrf90ohOvMhzu3K4V4DBXSVL+i9qo9fx4TBmdc4zbIHzV7DvkMo/TCNfGGY3YZd0uEzfC6drVWJq1Ow7+wg7rFyYbnfQqfYHlqFLWCgaAmeREogv154VPRWtarLD/u9pv2Z0k1zx2z+QqvS6GhZX+EOq+D1c0VttsPEt2PdnCkoLC2aZvxmw4hzUmzT9Em851+66A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmBycWJSdyji6Hd3rcCoLyyd4DN3ZsqKl+LWeHR9c9o=;
 b=LJvPEFMBO/KfYN+eFqwzLiUHSHuZTSRCXvi/iOy9lqK+Kj0OfO0wgo4eXEFcB+GsfAcZAURC7H+BHtfJqYLe/DfGMpuBYt6w9Qld8KDz99g1phRLcT+c3nF1gPTfoss1Gf/eQZUd+yq8gYV3vcwORhgcriVfxSRD26MQDo1mtErBbgYN1rINGRiPjAoIvQzxhREfdNGPO9FB7KvEXSXVy3hLEmwfsZl4ndJ26ypQXdgLLRF0+5QmpCv/7eb5rUVGX640a5jO1h9v4JKXK2/7M1NVP8QflrQAUigTJNXzlPmNmli++3h0Yqoe2pZmp/2ilYpDMpUcr/eF4MXIH6W9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmBycWJSdyji6Hd3rcCoLyyd4DN3ZsqKl+LWeHR9c9o=;
 b=DN4ydWfJSk9rIiYDihqSOqWryalKvKsa+cKaHKUcX2UcgX1bt3Nvd8tgLeyDlfu7Udja3uM8zEjwmEEs7ZIFYTHkSLSQ/lWldr8Bq2ol+84W/+1CTqfBWWgj47c+ApNLIaHWd3ugdna0Zu2rwHVK9u0+75qnylnyFKFTFrWoUQwWLl995zfooGwnYwB9OqdFwxGqllwFhXV1wbA/0A8xGkhB4shBJUJVzB4IbtlKtum6A6Dx7ovK1pykuLjlh9UudMpYSEJ2vF6yJWlUzZiLOf/14WWTHIqsxE2IchWjydfmwDjb6sAr4zhr2+/lkTeZRP7bdYvd+7O5AO1/9DCXmg==
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:100::6)
 by PN1P287MB3646.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:24e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.27; Sat, 19 Apr
 2025 01:27:10 +0000
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4]) by MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4%5]) with mapi id 15.20.8655.025; Sat, 19 Apr 2025
 01:27:10 +0000
Message-ID:
 <MA0P287MB2262D35E7FD54F6D721DFF82FEBE2@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>
Date: Sat, 19 Apr 2025 09:27:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] riscv: pwm: sophgo: add pwm support for SG2044
To: Longbin Li <looong.bin@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20250418022948.22853-1-looong.bin@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250418022948.22853-1-looong.bin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWP286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::16) To MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:100::6)
X-Microsoft-Original-Message-ID:
 <3e7f4d05-f7a0-444a-9b79-adbc944f7c3c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2262:EE_|PN1P287MB3646:EE_
X-MS-Office365-Filtering-Correlation-Id: e6630974-de70-44d4-f81a-08dd7ee14e0e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|7092599003|19110799003|6090799003|5072599009|8060799006|1602099012|3412199025|10035399004|440099028|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFZPc0pjdFplN0E2MWQ0d2tvdzZ1aTJzQUFmblRJZWRvbnNxeC9lZENWRkRh?=
 =?utf-8?B?bGdtSVpoWFNvakpvQ2tUVnJxSk5pa2IrOWl3Y2R2eU5RZXRVMkx4MFE2SUpB?=
 =?utf-8?B?RjZQanZxUmlrTkFNQytGNDNkeFMxNDY4OWtNL0pBVGM3SWlUQkdsTWlDZUJ1?=
 =?utf-8?B?T0t0THB1UEdkS1VLaW5HL3RnS2xjbGczbzZQQy8yNURwS0lpNmpUUFJJaXZp?=
 =?utf-8?B?ZUgrM0xUeTRNSzh1UTdYWXc2SDBza09wZ2RsWEgvOHZ2SExFWG1GTG5xcU1s?=
 =?utf-8?B?NDR3eEVoRTQyN0lpM1VUOTBZMngra0JQS3p5eTBtZHVhQldBa2d3b0RMbDQ5?=
 =?utf-8?B?ZE9jT3AvbDR1VEJkeEYwdzVPbkJCVHJWSWUzT3JWaklDNml0bDZ2ZGc4VGIy?=
 =?utf-8?B?MUVNbUp3RktCdTNmT1Q5K3VVbHV3SE5ubnBuMzlxL2wxckJ4b2J3MnNjMCtN?=
 =?utf-8?B?cm5oYkE0cEJOSDRDczZ3WVNDU3MxMEk0cG5XVmEwMmtYOHViVXl5WERPRlJq?=
 =?utf-8?B?NGwxT1dNRG1DeWl6V1pXVmoyV0pENUExZnlEYUQ3RzJGZ25tU1NFQTRWNlFm?=
 =?utf-8?B?S3pnbmx1MXdMRW1RVzNGamZoSE1kSnVzZ2dVZGRWVzFDVDFMOVlHd1U0ejZ3?=
 =?utf-8?B?cVZMQm9RMkg2NzJnV3FsNUZDM0M1NWlkRU5HejZWZEV3V0c5Zzh2d3NoUXB1?=
 =?utf-8?B?Zi9iTkNRNVNnd1VXY0Q2Z3h6N29lVXhmSDNtbHBlU1UrOWRMZTJKbk5wMm9q?=
 =?utf-8?B?VDBiNWJFWDBWRUJPK3oxaEhqZGxvd1dNSzE5bWJiTEdwUW1kcmRHUDhJL1o0?=
 =?utf-8?B?RXYyNFA4UG9ma0N4bVoxMkFIblVxQ2lYNTQ5N0U2dlBKSzdBZ3hIWlNRMzBj?=
 =?utf-8?B?MzAwUTUrenU1a3o4TjZMSUV4T0xYLzFqdmJMRmRzWmJQeVFkYjNMSEdMTElH?=
 =?utf-8?B?OHJkQnU4TFBOVG1XZ2Z4bUgwdDRkcmZTYUNHZGRVUUJVZVBWalNZaThqSXVs?=
 =?utf-8?B?ajZCeFQ0UmdkYWZMMVFKM1pFT3k5SHZpaDdQd2Foa3JxZytkM0EveGJqNjhJ?=
 =?utf-8?B?RHVtdlhiWGRuMmpISUJMQng5RzFiTTNRY3ROZzl5N1VJVDkxdm0vcVlzeFkw?=
 =?utf-8?B?NmlidHRzMXhBT0RzbGFIM2pVOUhHVHRvclhnV1VuQjdvWGhLWENDcTBLTHBw?=
 =?utf-8?B?TExadGc5U0kwbmxyZktMRXIyeHV5aHl5U0dBdytIWlorM2tEcU01Um9NN09J?=
 =?utf-8?B?YVlBWk1VYjNTVjNiT2ZzOWZ0b1ZwdnlCUEF5T1VxV1U4UVk1YWdlT210Ly8r?=
 =?utf-8?B?WmgrektkZFU4VzN3NFY5UjM3bnZob3ErdnR6cm9oVFdyWmkvY3FlWTYwdFdB?=
 =?utf-8?B?UitnWGJRVy9WaHowcHdsVjVtQlJMYTFOZFN3UUVBVGJEK0RzcW95U3ZmNFBX?=
 =?utf-8?B?ODl5UzRSdU9nVHpxSnAySjM3bkdNcENCbll0bVczbXVqWlA5OFJCVGR2YlM4?=
 =?utf-8?B?TC9TQkFqM3JSb2xnZ25wT2pjSUdWWVRVZVRrc3BSejJsbmdmYzBTOGxGbVVn?=
 =?utf-8?B?OFNyK0lJdVJHVHQ4S0RzaXBaTTdUZWpOYkxmdEVHVGp1MWlLS2FkTWVFeTIv?=
 =?utf-8?B?cThOcHA1OWk2SlM3U1R6VzJhZzZwMTYrZzM0QXJIaWlPOHhRenJSdUtUbEk4?=
 =?utf-8?B?eVVWTkFjbUtCMVdkNTJ2WVhRVkdPRkVQNWhiMjRtZ3o2NFp0bm1tQko3clVE?=
 =?utf-8?Q?BrpqzsPla06BlJpL3ZZBcTyi0p5sK9gE4zxNvQC?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGR5Q0FHTHVqbG5OV2ErQUhtQm1kSlVpdGR6K3dDRnVrcVZ4dDdZbFRyNFM5?=
 =?utf-8?B?TStaeit0eXVsL1J2S3ZLWUFOc0s1Nm50dUJpY2RucFZhclpMMlF0WXBNTVcw?=
 =?utf-8?B?QkNHTFJyZE1adXhnOTEwaFJTN0wyR2R1RFFBUElibVd5Nk4vMTMvcnNkRmZW?=
 =?utf-8?B?RE92eC9xOUxlQWhOSnJ0ZlVrLy8wbVlOUE9kd0poNzZNNW5KbW1SeUM4VmNZ?=
 =?utf-8?B?dDZLeW1qQXpUZzFDa1h0QUc1c0tmVWhUQW13NWFiQzVUL250d2JoUjlMZFJ6?=
 =?utf-8?B?MVJyQ3V6Z01WK0IvbXIwV1I5TWdxc3lCNWxVYkh2Y2wrOXpaTVNIOVBQbExR?=
 =?utf-8?B?azRJQXpjRHZibUdkODZqUGJTNHF0WXovRk11K0poUHR2TGJEelpWc1ZDd1JK?=
 =?utf-8?B?bHNKeDdlYW5MamF4OTFaVDRFenU3bmplYXdiUm91UUdwZW9GU1ZGS0xGcEFp?=
 =?utf-8?B?UWNpWTM5ZTdKT0FyQ2R6TEVPWC9CS1VXYzVVWVNON3hSekIrL2NsbVVGRDRh?=
 =?utf-8?B?ajdIUjF4U2FtVllOMkpZd3k0UWxqZTlvclllckpnY1k2cXRCWWtUeU1sNGFK?=
 =?utf-8?B?K1c0aXVQNUNKRTRnR2pCamkyV1hMRTZVRlV3K2MzZ2dZUTdib3V2RlRBUWpt?=
 =?utf-8?B?TE94U2ZvOGRVdlhGRHNaRzY2VzBoa1pMKzRMR2lCcTVWWkF4Z1FzSVppMlVG?=
 =?utf-8?B?UVFLNUJhaVJnVXpLQXNXS2Ric2ZYTXR6OEZXMXUrN0d4MGI0Y3NxY1RPejBP?=
 =?utf-8?B?cGNrUmFPRXBxSTNCMGFkeE5pd3JrSUxVTjBGbHZvTUNNRzJWM1NXMWdqK2Z5?=
 =?utf-8?B?RlJNblpjbkc3UlZtV1lWclpIQ1hxMW9RYjlCcEhjd01JdkFFZXNLaUljVk5n?=
 =?utf-8?B?UmlURHRHbTBQQ045RG9NQktSS1UzQ3FZZmNTOS82bzJiR3BNTlh2eXZwUGc2?=
 =?utf-8?B?RTl4Ylp0SFo1TU40VVhuU1hKbU9CNGtmbjBkSDZRZnBZZnByS0ZRMzBpcEpS?=
 =?utf-8?B?RHAweFVKQ29kR1lxMVJXUTNtQXZDTXYySkY2Y3BmVS9mNUpsKzBFTHZJczJm?=
 =?utf-8?B?ZHJ5aWRza0d4RnprOGZ1NzRtZFA3TVJzV3ByOGNEWnNLSmw1MEI5c0N0T0l6?=
 =?utf-8?B?YUdsNS84VjkxSXdTd2lMeG01RUg4NDlnOFVCY0pEVkdLOXduWWhhSGdFSEk3?=
 =?utf-8?B?QVltTHZqWW1oUW5ScnlhUnZiOE5VZkhOQ3kvMlF2Zi8reW5NMlYvd2dtcDRE?=
 =?utf-8?B?SGY2RmI4d1BDcmpYSXFQN0xDSkhidXdYc01wVkt4WkxYVnAya2J1aGxOT1Rs?=
 =?utf-8?B?c0RmQmVvdm5JOWlOK3M3VG1kcG1MeVA4Z3FUWXc5NysyOE1pL3RqK3RodWJh?=
 =?utf-8?B?bXp5T0crTEt2d05tT2s2Vm9WdksvSUlGYm91WE1XS0NPUkkvL1cxQ05yUUtX?=
 =?utf-8?B?dW02QzF5cTVSMWxBYnpibTlTQklpSjZsaTF4V3BmUVVCQ1Zka0dPVzUyMm1i?=
 =?utf-8?B?YWFEblpnc1dvcnVtWDVRaVF5clVURGErQnRLeTFYZjJjWDZSZFZudy9LN1A2?=
 =?utf-8?B?NjROaTMrVkt5dXY1Q0ZLRmhTSGorcldpa2FKTUUxZnRmdlM0R054bUtTeXNo?=
 =?utf-8?B?YW1SZ0FpWmpINGdRNk9ZbmI2OTNNTlUxSDk1Z2owazNSUjMxR3krQnU3aVFh?=
 =?utf-8?B?Qi9SME92bUd1VzFzU1F2N3g0bDQ4Q09LaDhqQnowd3VBRzJaZ1JvMlQ3QkdY?=
 =?utf-8?Q?KQN5L5hNehjyzEuSTgxbeB8qw/1bRWPIvBv/2KY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6630974-de70-44d4-f81a-08dd7ee14e0e
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2025 01:27:10.1692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1P287MB3646


On 2025/4/18 10:29, Longbin Li wrote:
> This patch adds PWM controller support for four independent
> PWM channel outputs.
>
> ---
>
> Changes in v2:
>
>    - Modify variable naming and code logic.
>    - update "MODULE_AUTHOR".
>
> Changes in v1:
>    You can simply review or test the patches at the link [1].
>
> Link: https://lore.kernel.org/linux-riscv/20250407072056.8629-1-looong.bin@gmail.com/ [1]
> ---
>
> Longbin Li (3):
>    pwm: sophgo: reorganize the code structure
>    pwm: sophgo: add driver for SG2044
>    dt-bindings: pwm: sophgo: add pwm controller for SG2044
>
>   .../bindings/pwm/sophgo,sg2042-pwm.yaml       |   4 +-
>   drivers/pwm/pwm-sophgo-sg2042.c               | 151 ++++++++++++++----
>   2 files changed, 125 insertions(+), 30 deletions(-)
>
> --
> 2.49.0

Tested-by: Chen Wang <unicorn_wang@outlook.com>

Only test with Pioneerbox/SG2042 and it works well, I don't have sg2044 
board in hand.

Chen




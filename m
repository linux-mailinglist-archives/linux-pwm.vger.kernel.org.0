Return-Path: <linux-pwm+bounces-4542-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AFCA03007
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jan 2025 19:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C522F16291D
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jan 2025 18:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4483B1DE4DA;
	Mon,  6 Jan 2025 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="R9m382rg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2027.outbound.protection.outlook.com [40.92.89.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3203597B;
	Mon,  6 Jan 2025 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736189969; cv=fail; b=ffpQV+LZAzDzKOgpsMkDxgKn0VRQ7Hv0AUZK/xoUQqUb01RG/ATNmJy44l4DOA+JhbL8P9dlXwiWKRTkNXL4oOPYb5Jj2PbCGsrj7UspSFFV9yp6PSVNj6LkuKIa5UPNB6UuPG070iL2qF2kPgz5SgdvaqiDV95OSQ2m1B5ywYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736189969; c=relaxed/simple;
	bh=smYyx4U1AMKRrELzeMIu2QMmv3HMDsERd3/3Q8J+/tg=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZQnS4nO58PH/ULTSZeVRbRuFBanUAKPc+SA9VqWFjAXxtgyAa6ux6WzX5uo6cI9qe72y8ERnoMLGqgYsHklSwuQE526EsFlX4gmY0XgmeOBoTFPgj+zZYrXQYuSG9VeEnrYoY5X11OMlBZlZHbneFTlLLgVqz/FwV3Hbt7xFrto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=R9m382rg; arc=fail smtp.client-ip=40.92.89.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAXqPrCKWOJ2r76c3vB0AoQ82sjQubToouZE4TkZ7aooXuXNG6wmS+ryrai72o5jQWFf7WsQoBWR8dDncen5HXT1uRj2c5/bZIL4tS/caDSUV5F6B6HnrD3WhJSU23RenAutx80JGD7xH4cL4FsOtqROBnemuUj7M7d96H4+B7geJ8sh5V+t+uVuauWgoCwN3PcdsSvUrp5UtjaDX3gSvKNI7yaYvEuZH8QQEYY31cy3DGfXOrh5Wbr3E5ELNEfX7v3EFOquddAeeetSrkGuyBhGgh+cw/ZbrqgIoQ2G6ip2DmRuXNpJnw9AzYQtbg2H++YTb+g5632CsmVgnGTE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwlkIpknUg/hSLit1trSHFDh99c066U9T5ExomDuBYg=;
 b=nMf9BOvGRTjzAaAJGw7K8b/YKZ/X/TJpWc8YPASUsciHiJRsdhHrHAWBnt9wcEu2xDO9OXmtaIEppLtTv4ThO2OvntpoDxjzITO5xARyMcU5zBiWCmIZUJ0T+gcKWZcxCIHUur5iN1xdPs/yWXQVDq5DIobfpGdzSrvH0EttZa1pcaMwamwtDTbddvoMTIBbVV0oDJFlEr7QkunFutPMI5tfqtBXOeRRO4S9paP81VReHV0gIkYPl7KWzT86DwFJv4mjpm4OcuBrAKTZqTUtdI/p0jpQCEYb3gfW1q64TIr02kQEikp/EjsV7h0BZVpDytg5Q1uK5IgwEx3VtNDEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwlkIpknUg/hSLit1trSHFDh99c066U9T5ExomDuBYg=;
 b=R9m382rgXdIm35QArWYGuQSR9HVyXyksFotTFXqROMifgWJYVO1VEFRkIg+CX939utjM5uivsJyuPdBpdrRxNVXwLwKMW2cVld1zqcyGLfNsAELMXcy/Vwh/dREIJAwfZGlwKCln4o9z+KOiAmHj1bFbhNq/nPYgiDkVMO2Vq01B2n8+ywT7jZOtA1RMP6hOgiC0DCXfzX6Ov81czmNrVMdyaMWagEtkS54jDi5DvaRjPrJdNqEqx2hiQiAAlaNbA/GjH66XOVSnJnwp0Ss9tqRT1qfJOtwreFwg6UsuK7bo41RtbI1484vTpGTVEyBLvWhpExRTuBiiITc9aIXqTg==
Received: from VE1P189MB1024.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:149::13)
 by AM7P189MB1041.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:14f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 18:59:25 +0000
Received: from VE1P189MB1024.EURP189.PROD.OUTLOOK.COM
 ([fe80::4c0a:a901:4d3c:e0bb]) by VE1P189MB1024.EURP189.PROD.OUTLOOK.COM
 ([fe80::4c0a:a901:4d3c:e0bb%3]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 18:59:25 +0000
Message-ID:
 <VE1P189MB1024E9669B8CFCB943D633E7E3102@VE1P189MB1024.EURP189.PROD.OUTLOOK.COM>
Date: Mon, 6 Jan 2025 19:59:23 +0100
User-Agent: Mozilla Thunderbird
To: william.qiu@starfivetech.com
Cc: hal.feng@starfivetech.com, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, p.zabel@pengutronix.de, ukleinek@kernel.org
References: <20250106103540.10079-1-william.qiu@starfivetech.com>
Subject: Re: [PATCH v17] pwm: opencores: Add PWM driver support
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <20250106103540.10079-1-william.qiu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0040.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::20) To VE1P189MB1024.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:800:149::13)
X-Microsoft-Original-Message-ID:
 <ee4a7ff2-ceac-4c6d-8309-b6def49b3ba8@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1P189MB1024:EE_|AM7P189MB1041:EE_
X-MS-Office365-Filtering-Correlation-Id: 51addd5c-a5b0-4e02-9597-08dd2e843cdb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|6090799003|19110799003|15080799006|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmVrK0ExZ200aHJ1NTlvZVIrMStlaFVFNUVHVzBDdEYvR3BIUWdtclpqbnEx?=
 =?utf-8?B?d2NROGIvU3g0anBGUEZGZWN6R2w0SE82eWNPZzNoL0FMVmplK0QvOVhGNWhs?=
 =?utf-8?B?WWhOQ2Ewd2ZUUXlDdk80T25iemV3WUc1Y08zaHJhY1l2NnRkcjRLWmNaS3Vh?=
 =?utf-8?B?QW5nc2hKTE1kQW10WEFJNDNoclJoT2N4OGZDckxxVVkvams4Z1JVbk0rRjJv?=
 =?utf-8?B?bEI1T3laRnByZWFKSkdWRiszcnZVRWVJcnBhZ3VYVTBQdllObEEzVDhoOHFS?=
 =?utf-8?B?ZzB6ZUpPVUhVQTRMeXNQdHI0UGpUZ0J5TGNHNEFxUHcxRU1DWXpEam5seDVt?=
 =?utf-8?B?ZTJrYnZoamNQUTlHclpGV0h3b3NrRG9sVkxOa1dLeGNUblZHaFJFNGlZUGRO?=
 =?utf-8?B?MXM2TE9uNUNUZ21VZmlvWGUydmo2OURNT29rRjAraTVmUXdKcXNhd3RoOS8r?=
 =?utf-8?B?S2psRGk4QWhNL1NBaE82bUxQMVFLVnk1aEkreDYwU2RTVWJGdFduV3B0aDcx?=
 =?utf-8?B?RmpreGR4d2tiM0pwNC9YNXpoVWZxSXYrdTNWdWtocG9mcm1vOEFnVmFEUDBx?=
 =?utf-8?B?dUVLM1BUM2p0b2dBUDc3cUdQUnRvVTdDSHpwYnlnRHoyMnF2bUVyR3d5Mjdv?=
 =?utf-8?B?WmJ0QlFveTFaSTFrc2FUTDZNOWVlNm1VOE5mR3c1aTRwaHpWV20vaU1GdnJm?=
 =?utf-8?B?L05sanRTbnQzSW9sVG1JaWpIQTBWQVlJMjRIZ29wbkdycFplOWdYa0JPSk4v?=
 =?utf-8?B?UytHZERuOXBwSHN5cGhRTG1ubnNEMFFKK2hOVXE1b1NGek53cGVpVUN4R3Ir?=
 =?utf-8?B?RmJsTVBVcENOaUtTQlFwRFcvKy9qcS9uT1BCUmJURVZyRUxaaWNKMlF3eEZH?=
 =?utf-8?B?M3ZYdmt3cTRKWlBxaDBMNkJvQUMrSlBFTi92eHBKTmh2OHVRUThVSHFDVWNK?=
 =?utf-8?B?TU5TbUcxcGF5cDJMOWxBa3RnMHVjVllvTmNESmVqbFZleEw4N3haSWp1M3RE?=
 =?utf-8?B?TEIrS2c2UTJLOWNMdUt3bWErOXFzVVpBYTZESVhqb0JzWWRxNDZyVVRZbzN0?=
 =?utf-8?B?UHMwa2NyZC9KYlhybE9ERTNkQkUxUmF2cXVrZithdUZsNCttYnNzajFqOEhm?=
 =?utf-8?B?QkZyK3V6ci90TTFsV0FNTlRVUzk0RVRCV2NLaDNiREdNT3hQNU5SSll2d1lY?=
 =?utf-8?B?VWsya0tSaDhjWWx3TzF2REs5Yk9CUlVCNjRPTE5yQ2lYcWEzMjIxeDlLRXVO?=
 =?utf-8?B?SkxyQlNuTDBUTmkvYkMzUUNnU0sySFZTdng1WEY3RUZydjllTHFRZXpGVkVB?=
 =?utf-8?B?aWVBTGxEeEF4UUJHZjN5MTkvQW9MRFREZlovdDAzYndhQW9Jc0RiOVhBZXhx?=
 =?utf-8?B?eEFUTGp4K3djMVVNZS9BMTl6ZFoxK2dnMGtHYzQzTnUydmxuYVV4NVdXRmds?=
 =?utf-8?B?VnhjRmRvZ3p5R3Z6cFVZdFFZdVFVNG8xbkJRUkNBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGZNSGFHYVVzamhOcVZaTTRtSXNYNE5oMUlJNXNZRTM5dTRmUkNQV0NyUUhX?=
 =?utf-8?B?SWxWa1RIL0x3VjhsYWhJT2h1Rmk0R0s3NElsalg4d0NOdVlJZ1cvRVVXeG9B?=
 =?utf-8?B?S0tIV2EwdnZoQXFwM2dabDFrTEg2SmdCcFBGcUVCbXRLbEh1OXYxTVpIY0Fa?=
 =?utf-8?B?YkFJOGVjdzlGeEhRL0lVWmFOWkpadFBsN1d5dUVYUTBWSlRLeTNUc0ZyNTBJ?=
 =?utf-8?B?b0UwNCs4TGsrT3FNbU9pUVlQY3ZSaDlPYzJjWXFGS1E0TUVITVBkdmZiWE1Y?=
 =?utf-8?B?ZkduM0ZZUENDbm9idGNJMWN0a0oraElHU0pBZFk4S0lkU0RhQmVKVU1ENHpx?=
 =?utf-8?B?UmIzK3F3OHRKNVA4SEJrK3ZCd29zUEgweHlpMFE4dzdsMGh4SFQxTWVhc1VV?=
 =?utf-8?B?bDdLTGk5YnpjS3JkeG5FV3Y4SE15dEJ4aDJvU3NoQXZRNkVDbTZoMFdFeitD?=
 =?utf-8?B?OWNVUHliOU1sRWJGOHpLZU5WUU5aT1F3RFhsUFM1TnVhUjgwNlZTMnl2UFNE?=
 =?utf-8?B?RkJaajRyK3BRVUUyZGU4S0pCUlNaMDl2enZia21INGpiVEdBeGhwcVM3em80?=
 =?utf-8?B?Y2dWbkIwSnU0eXhwSEdjS3Jpa0dTb3ZST1REd2l6WnFJVlJZZGtScVFObHdK?=
 =?utf-8?B?bDJhSjFpK0pPSnM1VGQ1cEdoZ0NpOG1QRXJEcGh5TmxQcmE2NmNFekdDV1pi?=
 =?utf-8?B?RDJNSHhCQ25sN1ZQanoxN3R4Z0xIZ0NSVFd2ODlrYklVR1F1TGpzVnRxbTNL?=
 =?utf-8?B?K1puL21DZnQ2b0pmMXFQbE91a3h2c0UwOGxjVHhJd0trcllRSVltRmJUNEhm?=
 =?utf-8?B?VkMwcFJhVUtPMzlKVHI0U29XYnp0MEoycUdsOHdtaGdRZ3RvMkNVNWJXb1Va?=
 =?utf-8?B?T1c4d3FqdFlYdjBJbzZvRi9Cemk4RXlBc1dDWmpJQ1V1cnJaTGpCMDBHczhK?=
 =?utf-8?B?YXEwckJJdjV0eTgwcEg4bFNkb1JUWHRRaWxYQ1EwTTNORzIzTzhITnRsRGZ6?=
 =?utf-8?B?THQ5cU44bEZQK2lINWxhckZLWVdMTlM1NjF6WEg5ZktENXZDRXIvM25CZ0t1?=
 =?utf-8?B?aTNrNi8wUHVvQ1FQNDJMRkYyOXBBekZvWlM5WlRzTDlBcHFYbG4wVW5rWEs0?=
 =?utf-8?B?VDVlb2w2ajRsN0Fjb09sZytqTTNHeHlKVThnVFBoOVdadkdoQWJTeWlQYjZi?=
 =?utf-8?B?VW43U1E3VWM3OHF4V1RQdi9ROUJ1aE9FQkI5Y0VnQUlvSVNoMU9iNnR4a0d1?=
 =?utf-8?B?Vm1aSkt2UFFnc0puTm1wZ1I2MUx4RExoQ3Y5dHBTNktOSEZLN0xiZmFMaFRW?=
 =?utf-8?B?amdwdFhGcnkvYzUyanN2cEIxemFwTXR2d2toWUdydHIrYzBHVGlxeFBhaDJ3?=
 =?utf-8?B?YzBWTWNZY0JSUjZiY2pRbTRueFBpOXFpNEkvWWxCMi93YzU2ZlNKM1I1dHZK?=
 =?utf-8?B?RXJvSWNZMlEzVU5YU2xnTW43QnJQOFdkUHRadDZ2ZUNnZWVnSGxLbW9OWDdK?=
 =?utf-8?B?OHY1VFFBbzdQNGZDZlVpS2NmUGVuWGZzNmFtMnVScUpEVTVTWUI3UDFjNnIx?=
 =?utf-8?B?OUQ5RUtNNy9DQmJ0NktaamFVSzBUM3RJUzN6LzVueGtxR3k3YXhnRFZyRzBR?=
 =?utf-8?B?Sm5CaXpJQVpJSmZac3h4cWdtb3B5OXpuMjh5VHRsSkZNQjJSc2xQd1NOeXF3?=
 =?utf-8?B?aXA3Q2NyVWZ2UWR4dTJnUGd2cGpZb091MnBKU0gwTUgvc29lMkJPcm56Vkg3?=
 =?utf-8?Q?QuQ7FaZpYgBHshGeI2WTqpbNGW1ihfZHCDx24CU?=
X-OriginatorOrg: sct-15-20-7719-19-msonline-outlook-3b3e0.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 51addd5c-a5b0-4e02-9597-08dd2e843cdb
X-MS-Exchange-CrossTenant-AuthSource: VE1P189MB1024.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 18:59:25.1457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB1041

Hello William,

I've once again put the patch to the test, and it seems the oops is 
resolved.

I did notice something odd though, when controlling the backlight  
bl_power 0 means the backlight is on and controllable, 1 seems like off, 
but instead sets the screen to maximum brightness and then stops 
listening to any value echoed into brightness.

The brightness is also reversed from what would be logical, so 255 is 
off and 0 is maximum.

Now the little text at the top specifies that the hardware only does 
inverted polarity, which I guess explains this, but I don't understand 
it. I also encountered this when I got an error to start with so I had 
to add PWM_POLARITY_INVERTED to my pwm-backlight definition.

But I don't understand why it isn't supported. Wouldn't supporting non 
inverted polarity be a very simple calculation? 40% negative duty cycle 
is of course equal to 60% positive duty cycle, 20% N == 80% P etc. I 
don't see why the hardware would specifically have to support this.

Anyways it does seem to work now so if others approve:

Tested-by: Maud Spierings <maud_spierings@hotmail.com>

Kind regards,

Maud



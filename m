Return-Path: <linux-pwm+bounces-2610-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391FF91625F
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jun 2024 11:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB7B1C20F1F
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jun 2024 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09A71494AF;
	Tue, 25 Jun 2024 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Bu/ml+vu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2091.outbound.protection.outlook.com [40.107.117.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1251FBEF;
	Tue, 25 Jun 2024 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308011; cv=fail; b=tWhNitBSCmPoY5qFOrBZRp58h3zpLTMbuYq2XAJSGicmYNuuhD05URsDrlc+9EhPxgQg/k2Tv1DRlcw3E18S/c0+J8e9snh4DcupWXh2m1bfOLOJSyqCtPBIDx3XT2OaJ1nUFwH+Ap6yrcHjTLalhTJ4oa6MPjxMvaWuWnq8W9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308011; c=relaxed/simple;
	bh=CWEkWtgJ0OLE2YTcr1+U8t/tsGd3NDt4mPfXm5tPPcU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VRNZM9PaTwGcNPzPEkfdVHEC7MrNGVyy28skCqVTZ+5u/j5g8bS1XgsafxRS8h4BrMQKp59gMEpFzkQ8FMHv3Cx64uxzWrNPRPcPWbEzemWgbjjjnO8bx9hrjdQQFv4c8e9S/IH3ROEiQ7JqatQWTt2fE+ocnzRmapbzmPDY2FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Bu/ml+vu; arc=fail smtp.client-ip=40.107.117.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0ZYbfNUTOdWtjTOX9F0jSx5udKtKWbUImU7C9xuxIIt2UWzidTT1CLMKXsmrK+6WDjJkOVfhZ+lyZ1p7451pHZB/mcAevdMEp90opHsDtLyYZRvGlp+ozqJqVIBU7PIsLupFZUBWoSw1cJVAvsYtt54je0cvakGV40wg2JCz+OB/SLVJmw1+yzdWx+aHVOZmzjT0BYDsAdcOANP11iaHw6nEOmtjnB1mq4dr3S3NbKPC3v+5cuxiUm8/9avPcbcA3Q0ye/SYMcN8bUpygKFPwd9q0LpDjSDIjvlvwRDGX1zGgeRo7o9STrmS825RWJx4TvEYAE5v6jiHI5HDS/KLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHxV2y0mfQVT6eAj0vVSutZ6fLKu1PNIo+5jMDqMf40=;
 b=glf4cybIR7+LTZE6G4PSWINN3WUWjDR8lUbQYYYgjQCp1MfFNFf4yYSqwPa3KdwsQgwMYDSfgp76wh7cWArcaldTl6OM0updaqqOnPLWjLNe6tSRaVqZWK5QWJYV+htMe/RgYqR1mt3R2SKkDAVvGWok7TlCh9Tz7ByjgbMz4eTDOp+rorr+ViO7ZIiQot/wK7TaOeE0KeaHN16pY90lDM5CvZUjQO/CGAOjsDavre/bo7uMXB/3FAmFt3Dxdv1rqkndpcn2CJYgN0MgBAoWNOgWqAYltGi3meft5BG3iAnfwDnaj7CuQsReMiBPCWmXXt3L+xbsSnLbsWvqCU2OEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHxV2y0mfQVT6eAj0vVSutZ6fLKu1PNIo+5jMDqMf40=;
 b=Bu/ml+vu2quI9Z89ibPehc/3eAIeMpUmZjD5XZN4v2I6zexAbQZlt3IYjPN6LrWFwxLSeZtFH79sVLllIXe0iKnmSZrtSs8bOfhWvuZLep+c3ushFrsyq+PVkezUW0nr9j+uXgZs2rteCaPhBClcyuzZwRiXC7IgAM+pVjuefd6mcZL4YLxVRCY+OmXvPSxKKvz2VEEtkveHwhZV5N7NKwnj5uVzk6XswW6Tj/ySFEfLW/gAdWbIJHWu081GLYMf0dawzfRc0L8TfeclDYTxAJfrskYboY26I+OOBp1Ah0xLWpC3mKcKTVBsV4ouU6+p+9WRD36lRBz56LZYsepXyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com (2603:1096:990:11::8)
 by TYZPR03MB8616.apcprd03.prod.outlook.com (2603:1096:405:b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Tue, 25 Jun
 2024 09:33:26 +0000
Received: from JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::1ff4:d29:cc2e:7732]) by JH0PR03MB7384.apcprd03.prod.outlook.com
 ([fe80::1ff4:d29:cc2e:7732%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 09:33:26 +0000
Message-ID: <9b457c30-6093-437b-b9af-44c3a768020f@amlogic.com>
Date: Tue, 25 Jun 2024 17:33:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] pwm: meson: Add support for Amlogic S4 PWM
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Junyi Zhao <junyi.zhao@amlogic.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
 Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
 <20240613-s4-pwm-v8-1-b5bd0a768282@amlogic.com>
 <1jfrtgj0so.fsf@starbuckisacylon.baylibre.com>
 <tnwdnwiruoty5yd42bmkupgg6hjxib5lblhqcyouoyx5y3zvnq@2d7cnrei24m4>
 <1jbk44htqr.fsf@starbuckisacylon.baylibre.com>
 <948ba34a-1e05-45c4-8ba7-66c72bdb6fa5@amlogic.com>
 <6bzysc3jwugo3epcxsef7uupk536prsc3phlf3m64n3jjwpxus@2uigg44uotuh>
From: Kelvin Zhang <kelvin.zhang@amlogic.com>
In-Reply-To: <6bzysc3jwugo3epcxsef7uupk536prsc3phlf3m64n3jjwpxus@2uigg44uotuh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:3:17::19) To JH0PR03MB7384.apcprd03.prod.outlook.com
 (2603:1096:990:11::8)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7384:EE_|TYZPR03MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: 597f82bb-d340-4af3-35c7-08dc94f9dd42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEdFQ01GaUJDbkVSN3h4MTk4MXhXcmtDYUVmdlFmR3A5a2xDRDFVTHpnNklK?=
 =?utf-8?B?enNLZ0NjMFFQdXBRSERxczZaYmFQa25RTU1aVXJGVXpENWRtUFh0Tk5QaThM?=
 =?utf-8?B?cHNrTHc3WWxIUS9KZm8xMmczajluelFsS0RpekZ2WUhrOWtxOG5tYTNEV3RP?=
 =?utf-8?B?bitNcFozRWY2Q0VMUDRjRSt0SldndmNpQ1VRRlVIL1VlVUQzZGF5cEZTdmE4?=
 =?utf-8?B?L0lEY1VLbWhkU1lTdU9OWjlHM2hXQ2R6bDd5emlzZDBNcERNaFRNS0JmQnZP?=
 =?utf-8?B?bW5aZW1ZTHVKSDlXUjU3V2JKSXNlZkRwQUJEdXd0Q2pJSFRESGJNN20vMUFr?=
 =?utf-8?B?WVBNK0hJREdQTnBBc0NPU1QrZDdlYlUxa3gzT1h1dk5jSVdQMG0xdk9lWWtm?=
 =?utf-8?B?Ui9jZXBuNlQwbldoMzlUTTB1UWdDK01GbVY3UUtYRVRMVXFBQ0FDWHZaWitL?=
 =?utf-8?B?SkFML1FudVdiYUQxTG5WNXo5ZFZHQTJ6aGtkQlhsQ2hnWWpKMis0V2pGOExi?=
 =?utf-8?B?elVDczFBZFM1SGh0RWhCbTZkaCtTUmc0RGVydnVwWWJMcHAyS1MwUnpVN2JD?=
 =?utf-8?B?S0xRR1E0S3BTKzZkMFJmSDUzdndvWHJScEV2Z0FUQVJ6TmZlcVhxUWpHREZK?=
 =?utf-8?B?MDluVWpXQWlRZHdaVjVGQitwc29IVDdBOVZSVUFZUDUxWFZOeFo5K3dsdVZH?=
 =?utf-8?B?TUl6NHJOUTQ0LzA3VW1Kall3Z0NzQk43MVl1UmYreVozSnJKdmdTajRBbS9a?=
 =?utf-8?B?RXVqS1dKOUtiMDIxZytpcTR3Vjd3WksxWmRJS3h5RWgyb1hlM0ZWaURpUFVT?=
 =?utf-8?B?ek5KOFdyMENlbW1mWERra2lLMGpOdGhDdmRZTDNNYmlqVEdEck9RcUtiRkNw?=
 =?utf-8?B?SzdnL0MxZUljUExkMWJUTllqZVZZMlpaSDdTb0xYWERjMGg2UWJ1b21UNzFo?=
 =?utf-8?B?OUdPR3lwSU9hWlFvNCs0eXh4dEphbXRtb21EcDdKaHIxS25RMitvaUNOejhm?=
 =?utf-8?B?a2pORDErbnluYUZ2WFBicXFvSjB0NGFXM3FhY1Q4NG5SMldIVDJEM0RMTGxz?=
 =?utf-8?B?UlJldVBheTdzNmJwd2VFZmthTGRJd05OVEtyYnRkdk1GZEZhb2prWEFGQ2Uv?=
 =?utf-8?B?d2loVmFMV2RvQjliK3YycUFFSnR2NU9yaWhFU3hQMmtUcWdhbmJ2Nk4vaWtG?=
 =?utf-8?B?elhaQy9oSStkM2hqWmd1Z2FiNGFqeFdrS3JkR1hZMVBkVXFLK1ptdkVUN1c4?=
 =?utf-8?B?VHR0cU9WTitka0plYkQ0U3RINzhEVXBIbllLS2VuUk1hR3A5K0NTaFBGeG5M?=
 =?utf-8?B?Z3ZXQTVObWwveGJacEllbVkyT0J0NCtUeE1CbFo2anQvRzhiN0k4aFRBdStB?=
 =?utf-8?B?Z1l0UVgrSEo1TTZqVXlVdDZxdFhKQTY5VEhWbXljS1AvbVNadFZRVTI0YWRL?=
 =?utf-8?B?dkxYdWNSdkg2eFMzN1dmVVNyZTJtN1dMY2pxQUNIRnpNV0FkZ0VGNVhabUZ0?=
 =?utf-8?B?Z2I0a2JCME5GdS8xallHNjloL2xyNzZyeEVWOW9Qa1Z0YkxmZzdoZzNaS213?=
 =?utf-8?B?VkJTbCtnMDh3L3I3TG9SVWpYOTluQmZGZ2dpM3ZmVHZPMHROWDBCZERtbVVD?=
 =?utf-8?B?azhGRS9oOXNUV0ZYNzJhUG5YcWpLNWVFTmlsb1owblVaVmJmaVVIMmcrcGt6?=
 =?utf-8?B?YUh1azcxUHFxaXU5TkVZMmQ5VmsvSFlad09JS0pQWVdDcm9UbkpKdDJGRVpZ?=
 =?utf-8?B?QlQyWWFOcjBNalJteUJkS08wT1dtc2xLVUROd0FlZnBBcGhHSmswdm16Ylhj?=
 =?utf-8?B?NjlPQTloaVM3SEZUamZCUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7384.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(366013)(1800799021)(376011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTZqNnNxdmZWV2NDUEdFOUhLTVJVU0RLWUJqSHhBT09tSVE5UXBRNGhNT05W?=
 =?utf-8?B?b1ZjUVpYaG5NS1JqVjk2S1dydk9ZZy9vSGhYTWJLSlR0N2g4bWs1bDFwVi93?=
 =?utf-8?B?d05yRzhyUmt3V2JZR0pBNzkvMDQydEZVdTl3UjRuQk11WXpqTzltRDU5QjFX?=
 =?utf-8?B?c2hmZWtZMGE4Um8xSnFSaWpLVmF6SlRYdnhBR0lmZHU4TjRSTWZnOG9LWlNQ?=
 =?utf-8?B?eU82Z3JwYU5uQktDVnBXYXVlNXNKaGdsK1dtMG9CYll2NHRZeHhrWU1KQWh5?=
 =?utf-8?B?NVBVZzFGeVkvQ2RhNEZvdi8rWEgxbFFTeWdOMWkyeFNtckxzcVhWenVETEJw?=
 =?utf-8?B?UGtJczcxR3J6S0ZhalZ3Z3lSZjc2a0RIZXNjMmRKWjNtR3d0NURSNjUvQm90?=
 =?utf-8?B?N3AzOG5JS0IrZDdpNGk5OGEycG9MQU1PTDlEWkd1RStzNExSTmQ1eFNqV0xh?=
 =?utf-8?B?bnVNWHZrYmo0dVREWEZWai9OanhaczV4SVZNSFJkV2JxaHlxcDVyN2E4UEZl?=
 =?utf-8?B?ZnFCWE1KdGFVUmRxSFNsck1RVnhoS1FsOTE3QlN2djZqVTU0MElzZExoYVZu?=
 =?utf-8?B?NFJIVllJVjFGbE1uazV3NFRDZDhTM1ZlaVRRUHE0WmtzNVh5b0Qza0NjTUxM?=
 =?utf-8?B?bmVISWZpVEE3SEFhVGZUT2ZiM2VlQldmZzYycW43YlpZa1ZUUHpYWGFRNGRJ?=
 =?utf-8?B?QXBvcjJHbzNGQTVLZ1pINE42T01ybXdkV0hES3JsM0Z4bStCd01RVEdrSlFw?=
 =?utf-8?B?Rm1HeVoydmZuU2JwZU81NzdUUTNhL200QU5QcmZDMUhGNlpCNW81TzhZQnBy?=
 =?utf-8?B?NUpESStHTzNIZTQ3eXJDS0l3eDBjcTdSdHd0Zk4zNjB3K1NuN1dpV1JZakhv?=
 =?utf-8?B?S3MxdzVIMXI0YmoxT0tvamJIdmE4WVowQ1NsejFtUUZ0TUs5V0oxbVNGQ1JE?=
 =?utf-8?B?UGc2OXZjTkQvaDFwUWVoRHZCM2h3dXp5eDhueFlkK0s1OFJjd2Z4NWVBWnlX?=
 =?utf-8?B?QndWVmNGcSs1eWtZaGdpclVSVFN6VmZ4dDREZHk0NXpMdUJ1TE8vWVBwT1Nx?=
 =?utf-8?B?dHJMY292UGNtODJUamtoUHI0c05VTkY4RE4vMC9vUVoxdHhvWHRZY3hseU5t?=
 =?utf-8?B?eG1JY2JrdzZKcS91cnZuMFNJcFZhaWpYUWZPVUNjL1hKMHBsSlBKbHE0R05O?=
 =?utf-8?B?NXpNeVB3cHNrV002dVRRWDZVRVdYMjE1L3pGdlNneVRWY2pmOFBicTI5WGp2?=
 =?utf-8?B?aWdxeElPQTVsR1JMdno5RDVZM0J6MXlhazF2ekRna2VwWmlTUHdEcmFDb1h4?=
 =?utf-8?B?SE1hMkhtSGwxbG1NSGVxbjBwbHBTWnhVaEZxcThxVDlWMzJsaVhxakFWKyti?=
 =?utf-8?B?Rkp5TXhNYWJkMDV4MTY2c1dUYXhtUHB5UjhGZXdGZkQ5dWhTWlJ0YXcyMFgx?=
 =?utf-8?B?VGltT2NNb2dNQXdZaFFzSlE5VC9wRGRrN3VBOHNrL2l1TkNQMk5keXVCNGhS?=
 =?utf-8?B?M1dIdXpVMDNja3RGdGtSZ2ZOdWYvOVRjMUVBRGxGT1lCUU9JSmc1U1FtR215?=
 =?utf-8?B?bDRjc1Rjd3dZQ1EyR0lNbnJZWE1JLzZnclpVMXA2aTcwT1RoT20vcWlaMExP?=
 =?utf-8?B?bDhSaGlxTWgzNW9XRG14K3hjeEZkd2MzdHFoalJ1T0x6bHlSTTdSTHlJZk1M?=
 =?utf-8?B?YnE1NndGY0FXLzlRbERJODdPYUZSM0x3TzRiTklYbVRRRjJGaG9OeUNvc0R5?=
 =?utf-8?B?Q2JYeEorSmNYNnhYeGRMdE5SUnExQzJ1eWk5UXVGR2NvZ1dWdkRzV1prL250?=
 =?utf-8?B?c2hJMGlON0dub1BMNCtDRENZZlh5ZUtwQXFFYUNrU3NNS0JDa3NWcnl2eEZI?=
 =?utf-8?B?M3pKNGZEZDVjdXRyVitJMExKUWNObnpzOFNjdU4wODM2dUtINHFhSHVDM2g3?=
 =?utf-8?B?SlllTWJTMm1LV3BtT0ZXWDVqZDMxaTV6ZlY4V0wzUFBrNFJhdlJZN0wzMEhG?=
 =?utf-8?B?VUxvVWtYdHg0dWpkdXowdktySUdkQ3U1ZjFiMGNIcytDSUI1RWxTMlhKWUwr?=
 =?utf-8?B?N2Y3ZDByamxOOXFLWHVVdzZzMWtDVzF2a2NEeW1VUlUweWxJLzlMN0Z2VlpX?=
 =?utf-8?B?Z0dOcGJKcVg1WFA5YmdUck5VZkZOWGxwajh3UVFpbWVTZVRWa2FDUnBVRWFz?=
 =?utf-8?B?Rnc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597f82bb-d340-4af3-35c7-08dc94f9dd42
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7384.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 09:33:26.0505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66IQSggKDCViwF1X9k5VzPfaGavnAUvpZHHcWoUylhf3EIaBLENe96nnik5bWZON7aPi9GAMe9Opx9j8pnoM6ngUqviUmU6A5v9mIdlTMhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8616

On 2024/6/17 22:11, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Jun 17, 2024 at 04:44:13PM +0800, Junyi Zhao wrote:
>>>> So yes, please use dev_err_probe() also to handle
>>>> devm_add_action_or_reset().
>>> My point here is also that devm_add_action_or_reset() can only fail on
>>> memory allocation, like (devm_)kzalloc. Looking around the kernel, we
>>> tend to not add messages for that and just return the error code,
>>> presumably because those same 'out of memory' messages would proliferate
>>> everywhere.
>> Hi Uwe, I didnt get the clear point.
>> So, if we need "return ret" directly? or keep "dev_err_probe()" to print?
> Please keep the dev_err_probe(). There is a problem with that approach
> (as Jerome pointed out), but that is about to be addressed in driver
> core code.
> 
Hi Uwe,
For this patchset, is there anything that needs improvement?
Thanks!

> Best regards
> Uwe


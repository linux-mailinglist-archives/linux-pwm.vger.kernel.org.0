Return-Path: <linux-pwm+bounces-3978-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E3B9B5FD4
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 11:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34C62849A2
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 10:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DAA1E2833;
	Wed, 30 Oct 2024 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="AnroVQXl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2095.outbound.protection.outlook.com [40.107.104.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F61E260C;
	Wed, 30 Oct 2024 10:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283293; cv=fail; b=MgF2ancDXaIYRKnuUg9WtNFYqcqrFcOU+44XHkp5nsllhOsIqCR644y2GtZ4oiMzaCyN98u/BBN/igZu/a+xmUAjEK00I4WNm4Dm+FoYV9apRaD4/2KMwRUJ8pZY2SOrPCp+pV8ohvOFuAXhGSgLtB91ymHJmm8lZ4cbzZUV2/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283293; c=relaxed/simple;
	bh=cHmvn8NKjv05fvAVVCYYQYbggVglL8IRNC/J9HfLyGs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=d2aactmz3W4T0NJGrv/7Z4ttS6GLMP8vnch8U7IXIAAJGBZRWr4J0Xo4ObtrLaitS04mVpApfSq3t6gLiTD5r253l1fM2XyyuaU6jrpQpJgWvMMqY+1Z7mQC+6h1VPLUahKt0mY6GTzHL4wFT31/lgOWd9sw1N+QZK+kPloQaJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=AnroVQXl; arc=fail smtp.client-ip=40.107.104.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXFLIZVxiG0JWJ3L3xdAJo8PLy3xCrwhtTATaPO6vYbpS9n6Bj5q2AgwvG9lQ3baJvdtJhZy7lxFjpgwnOzADUqSUxQ+mFKCYi/5e3Km/Plog+O7CKsGr2kH8DXjf2DxgGutMkR6rddvNIsvpEBwsuTFdK4NLD06MMa8ncKZGmz2cbY9soEX1G/gfIYj/llWJ0OYtTaYStzJPwRC9uBTR3x1jBzjlsImUpNoGPLZqfO144mMMFgxbmymrU8eOxFwNekYGxuTUYvX0+jAaPdEFf+N/fE+U+ALcOreIrtCoJYZdFcCyqbg3gJBQaUmxUdsj5FnOOwgEHTIOAxvV7X6mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRA7M77CyehTHHby9wOyhHV6HkJlYGFfqh1Yt9i6U20=;
 b=aKPK6RxAJE+Q1zHOMfb39Y0RN8Koi1kfhYCGw+LT5+AwNpbL3oyf4f1pG7QcbQtfwi/Ak/HS/eNuHZOpelUKpML5FLStQgBJ9MxAzlQKOAZhviSDLXpcVeRDqnyq7/CsCSQi1vSl06IuGQ8nsW++qfX1UIo+AgxVUgPtiqUlVvfjB7PPH+K01jRP0c7UTE3gZHoZ37ldKmxjtGtDdNua5tsKODenb1RwLZqimI9dkG1OuYibpoPWHyw7n8k09Lga4M2tsNv33aac4NvIJW6DY/RT3NmmiM+wDLiQ0OhzrnV7NUmChJ4fw/Bm2x09hRyrgIgu5QZuYZzGAEESjZ8JIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRA7M77CyehTHHby9wOyhHV6HkJlYGFfqh1Yt9i6U20=;
 b=AnroVQXl9cROhUSdJn5HdAPf1pAENugHK0TkZr/6sSlJcJTmThAEsZuNkwzU19z8bHbRq2Cnm61Ot1wtf1vCjrTJ4q89MgYzCdwsSX/gFHTKhcwe61hrJToMlICnNlHAl7RDIDMIxQX5HIuyqiNCpBvuZhFeFpJhJR+E1y9vMno=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM9PR08MB6034.eurprd08.prod.outlook.com (2603:10a6:20b:2db::18)
 by VE1PR08MB5632.eurprd08.prod.outlook.com (2603:10a6:800:1b3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 10:14:44 +0000
Received: from AM9PR08MB6034.eurprd08.prod.outlook.com
 ([fe80::9ead:b6bc:10eb:ef35]) by AM9PR08MB6034.eurprd08.prod.outlook.com
 ([fe80::9ead:b6bc:10eb:ef35%6]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 10:14:44 +0000
Message-ID: <184f8707-0b4b-474a-b2d4-b54a3438f4a3@genexis.eu>
Date: Wed, 30 Oct 2024 11:14:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/6] pwm: airoha: Add support for EN7581 SoC
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
 ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
References: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
 <20241023-en7581-pinctrl-v9-6-afb0cbcab0ec@kernel.org>
 <bf5lpb3dwfywzgnbcel6de57ick7hfzxfaovyqrt7juif6tgp7@sdmugrua6t3c>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <bf5lpb3dwfywzgnbcel6de57ick7hfzxfaovyqrt7juif6tgp7@sdmugrua6t3c>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF00004586.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::452) To AM9PR08MB6034.eurprd08.prod.outlook.com
 (2603:10a6:20b:2db::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB6034:EE_|VE1PR08MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f26d95-e867-4f9a-c233-08dcf8cbacb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1ZtWndPcExCOExJUlFoYVlyRHNtaG4zd2RSanA0Z0xWdVl3QjNES2lTVjI5?=
 =?utf-8?B?Q0dDUnRMYk5XdFFTZTdBYTQyZncxNU85eGV0eWFYUHZjd1U1OW5kQmU2N096?=
 =?utf-8?B?UkExNks5RWVvY2tGZnZQZmUwVytCUmJ1MHVmZnBsb0cxOGh6UVFsK1lLQ21N?=
 =?utf-8?B?eGtyTGx6OGxOUDc4OGZFVjlVRHd1NnZLWHRjcEpxdlR6VzZ1WkY5L0o1QUps?=
 =?utf-8?B?eE00MExNTWVhRWlBYkVYVi9kUExQNFh1cURaTDl4cWJOT3V5S2FsR2JvMzZQ?=
 =?utf-8?B?T28vbm5KcnloUTRvNXFiN2F5R3BiVGhoZFhYZit4SFRYcGhTcmY3bkFXd0lZ?=
 =?utf-8?B?UFI2YkVpNGtaN2VHWHQyY282UnFBYU5KazV5TjZZdEowc1dYdjhlZUJ5OTdR?=
 =?utf-8?B?Q1ZaWlh3VWxCRWVQR014TDl2YnFTWFZMUGU0dHEzb0c1Zlk3SDNiWkN6NlRI?=
 =?utf-8?B?TXBXUE5jM0w1cS8vSnBWTVo5T0RxbE1hOXA1TTFvc2hZYVR5Z05zN2trUVpn?=
 =?utf-8?B?bTBWUkNvN1BQTVAxTUFRcis1Q0FjbHdQMjdvMjFyS0Y1WVMvU084OEUvcDdQ?=
 =?utf-8?B?UlN0NHdJVWora1ZXMEFXRzJhUDA0OFYya3QvNjRSazFlb0YyQ01iT2pJSUtn?=
 =?utf-8?B?SVJVVndWU1l5dUliM0ZMQUxrdTVta3V5VHgwVkROS3hHQWJKanVvN0Joc2lZ?=
 =?utf-8?B?aFpNWFoySmZFZGs2YnJ6N2tVd0Rnb2ZOblYzdUNGSjZvcXVXNFJ1aHEwdHhU?=
 =?utf-8?B?Q3BRcmljbmw2MHB2SVVCRkgvVDVGUUc5R1lsc291dUw2eHZaRXhDbWcwOW1t?=
 =?utf-8?B?eFFyZnYrSkppUGo3WjhSUzdFbjg0dktPQmdSTElWVUh0VXlwUDlNZXNjSnp3?=
 =?utf-8?B?bXl5MXpJdjBjdHoyN3VtdnhMVkpqMzg5UFRFZXE5VG5qWXdwbWNvRkRVVEY5?=
 =?utf-8?B?aERteEU0cUdJaTY1NzRDaytja0EwSFZqSWpxTnpoN0NSYVdIaTl2MmRDRW9W?=
 =?utf-8?B?MTZ5WlJ5bDd5SmwvY3RUeXVwMXJZL3lKblVMSUZoaHdscUVnT3ZGaGdqSWxI?=
 =?utf-8?B?UkNZUHVCWmZTeXdvV3JIWkQreHhQb1dETU12VEZVVHhQQ1RpY29QaG8zMFA5?=
 =?utf-8?B?NitMUmdEL29jVERwTEMyRm9yWGc0RmRpa2VSZm1CK2pQeWhXWk5oUmtsc0dZ?=
 =?utf-8?B?S2xVTDd2M2RxSm51VWY5UUREbFVRdWNRdlFyc2RHNVArd29uZlZBaUFKQSs1?=
 =?utf-8?B?VkdYTjB0VDJPdnVESFdlNTF0bzRodEVtOG52LzRSN3loR2VQRERxMGgzemR4?=
 =?utf-8?B?WjFuNVNFWkRGcEtTeklSRncrSGxJS3BMclRiN243cEI0Z3Z1VTZ0VHpWQ1FM?=
 =?utf-8?B?RWhPemFwbVNTS3h1V3haamQxcVl4S0xIb1NHZUJqOE5yR0xmMUdGOEpQL3hm?=
 =?utf-8?B?VndTOUx1ZlJFQmo0NkJUVEFyUTJoZzlhM0dFSlNJWWQ1UFQwQjl4cmMrVkdU?=
 =?utf-8?B?aHFQWWoyQXRtbEJSb0VMdXBVMVBUSmhEZmM0SkplMzVJVzhuSEk2QTk3Q3lD?=
 =?utf-8?B?cVpJMjYxT0pjZDdJZFpBWFVpVG5Sck8wSytlZ3ZWd29Wd0RFa3h3UUhmZG1w?=
 =?utf-8?B?cXdLcWMwU0tLQWlSWUhDOUp3cDVPMEVLeFlqNzJDelVYN3N3c2FsK2NYZlVr?=
 =?utf-8?B?eit1QWpEdk5kaXIreVJQblQ1Qld1VUpLTE1lVlMwTHp6Y0RMYWNIc2RibHJ6?=
 =?utf-8?Q?ujs0kuCoqTOfUKQwIfvnGB6FL3G1Yk/sniQLK/H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6034.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2tFRzMxdnNpL2NEc0U4Mm8rLzdobGNYZ1BLSnYwVmJzVjRHZUJLeTRtZGND?=
 =?utf-8?B?cU1qYWFTOExOYnNEMDhUdlVxVVdjUVFmNUZnUkJaU2N6WUhOMXFMZzB0Qldw?=
 =?utf-8?B?aE8yVVBoNzFOWmxmd3Bwa0t5MTZPek5wN29pbUYyaERzK0Jmekc0OTRYQzFw?=
 =?utf-8?B?bE9pWEdtTjI0ZjNtTjJWeElkWWFmMENoUUhPcTh0OU1FNTFuVnN2Vjcvd0o2?=
 =?utf-8?B?ZE9DcW9HOGRnWFJwK1JmVVNTK3hodUdJY2pIWGVONm1jbENzZVB3cDRCV1ZM?=
 =?utf-8?B?K1pEMmtyaEhDNDd2dzJNVHovWDUxQTNseXNzMzR4eFFiR1dySXUwaFg5UTVC?=
 =?utf-8?B?TFBaczFWMGhING9UNzNlcktwKzNPcmdXcml5YWFHWml4RnRlY0t4OFZsdDR0?=
 =?utf-8?B?eXROd29WNFZuQ2tJMWFkN3Z1V3VxY3RHWDFRVVgvMHZEVUhlcm5HdTFqMVVE?=
 =?utf-8?B?VlJieUxMdjMreWpKdFh1clRnMTlPRkNkSFRmOUJaUmhkNjJURXB0bHJtNFJq?=
 =?utf-8?B?bDhLNnNrcEVTMFFKVTJDNC96dmNZYXU0eElPSkVnRUpNVG9qTmlVZ24xcUFQ?=
 =?utf-8?B?M0xjNU96SE4zYzJuL0k5aHJ6SW1malErcEZSRFF5VTRtLy9EcS9FUVlieE00?=
 =?utf-8?B?c1JKVHphNFd4TlpCZUdpa1pIVkE3QUtWMFZlS0cvemRGUHh2TzlOREdLQldD?=
 =?utf-8?B?NTNhT2pzODJZdEpiNWVXK0tHSUFLZEs0dXVhVVdIdDlSaDQxSy9BU2F2SCtr?=
 =?utf-8?B?UDZFbVdDUUkzS0NveHpWWFhkRUpNL0dzSFVmRTZhZHRqeXN3eGdkOWVLamNk?=
 =?utf-8?B?NEJoWlViNjZ3cVNNN0k4d24vZkR0dHpuNXphRXRmOVI3T3k1MlQ1b25ONkRK?=
 =?utf-8?B?Rnc5blRGSWtzR0hqc2N2WDhvSzVtU1dmdmhwaGc4clBuOVpLclNGUGxJYitt?=
 =?utf-8?B?enVJc2p3OXUzVXZRd0dGU2YzSlY4blZRNC93VVFhK0lhSnFpSUxubC9OTmJ4?=
 =?utf-8?B?U1lQQ054Z3RUNWZBd3dJQmZ0RmxVUlFjNFRLb3ZtVSt5czFvTVE4LzJGTEVD?=
 =?utf-8?B?VTg5dXY5bVBCZGppYUZpbUozbGJHbStCODZLSGl6SDYycDNGRDI1MWRTODhi?=
 =?utf-8?B?bW1DYWxGYjEycnh1cHZoUmJ4ZjhaRWFSRWgyd0FSQ0hLYTZTZW5oQ3dQZ3Vy?=
 =?utf-8?B?RHdNWDVoSGg3ZUVPR3hTRkk5L0w0SmFTSlFNYXZCemhRTTI4clhWZS9wN0Zp?=
 =?utf-8?B?MGIvS1B0QkNYdEUyNlYvNjBhUlRVa1NhcTlzTnQwSlZCbFI5bExrRmFsaEI1?=
 =?utf-8?B?KzFYT3Z6SE05VjlRV2ZlL3RnRHVNZW16YlUvZUFIWEhTNFhwUHIwaE1GdWFO?=
 =?utf-8?B?cno4QSt4NTJZbkkwUlgzL1FHU0YxTS8xeThLTFBYdmRyblh0eHE5MUpvYjB2?=
 =?utf-8?B?SDhvRzBMZFpZQ1ltemJLdUxPZnZFK2dEZXFlQXlPdThHaytXOXIvaTJMdGVU?=
 =?utf-8?B?NElONGNJUDBKVWZyOFRYeFd6NW1uV3d2QUdoOTRvMU5LclN3dkxnNFo4YldS?=
 =?utf-8?B?a01TNEpXZm9pU3JiakxVYU9ZcWxkU2ZpcmZyVE9iOU9tQlpYem5waVRmbFpq?=
 =?utf-8?B?QTZ6OFZlSmN4MksrN2U4dHhPVnFKT0NwUnBSMjkxUkJPMlZaZXIzS1F4TlhF?=
 =?utf-8?B?UkRuSURkK0k1YlpxTDV1cWJ4bmxsV25kL1E1N2hXZDVMcG5wYmsvbTF4WVBy?=
 =?utf-8?B?bVpveHlSMTYxU0MyWFp3UjV3a3grMjdmR2FnaERBaUYrTlVjckdJKzBJZ2ZY?=
 =?utf-8?B?T2JYU2lrK0xOV3hFTTNVMlhSS2pHWkFXMXZUaTBXS3FNUWxXYW9IY1dwZkhS?=
 =?utf-8?B?L2NwVXFPb3d3blVBMXQ0bGF6TUtJR2Y0ZDhuSWUvTmVvbXJMblVGanFZZXpI?=
 =?utf-8?B?R1hKVmxXTWNaUk8zelJMSExkdDZEVlNseUlVb25WRStkUzF4T1ZDU0E2WlN3?=
 =?utf-8?B?VmpkbkNRcXpDY01BaTRYTll3V2F6Ti9kZmZQNnZmSFZCVVIxcm1SNUVrZnAw?=
 =?utf-8?B?SkFzMGttM2JVeWpRWEJoM3VtQytJZ1poN1EvcndYNkQ3MUFOejRxTDhZY1k0?=
 =?utf-8?B?TkxVY0NWMVgvck96VzhRc29XTFZjT1lzUzREODJCTkZQanpyOStrSEcyZUJy?=
 =?utf-8?B?ZWRVOXcybk9aSHpWMXB2RE1OOGJKekpvTjJBaG94dWc0ZjRkbFNZZld1aHdT?=
 =?utf-8?B?Ry80L1o2Vzk0eGR6S2ptampCamt3PT0=?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f26d95-e867-4f9a-c233-08dcf8cbacb8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6034.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 10:14:44.1189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBzNPN46DefzbSsAlN//mkoNNObEaZ1AqiINUZsCX0jjtUK2B+hYhE1JSPOEiXmjmRIJaVb+sUMAf5+7gCZEW6wyy26NAUJ7afKoLc7xSeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5632

Hi.

On 2024-10-30 08:32, Uwe Kleine-König wrote:
>
>> + *  Limitations:
>> + *  - No disable bit, so a disabled PWM is simulated by setting duty_cycle to 0
>> + *  - Only 8 concurrent waveform generators are available for 8 combinations of
>> + *    duty_cycle and period. Waveform generators are shared between 16 GPIO
>> + *    pins and 17 SIPO GPIO pins.
>> + *  - Supports only normal polarity.
>> + *  - On configuration the currently running period is completed.
> Maybe I already asked before: Is there a public manual? If so, please
> add a link here.

Currently there is no public manual for this. And the existing manual is 
not that detailed.



>
>> +	/* Configure frequency divisor */
>> +	mask = WAVE_GEN_CYCLE_MASK(index % 4);
>> +	val = (period << __ffs(mask)) & mask;
> FIELD_PREP please.

Per my understanding FIELD_PREP only work on compile time constants.

MvH

Benjamin Larsson



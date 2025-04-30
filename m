Return-Path: <linux-pwm+bounces-5776-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96243AA4015
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 03:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3EE980B4C
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Apr 2025 01:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BBE12E5D;
	Wed, 30 Apr 2025 01:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MeRhU1cx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011034.outbound.protection.outlook.com [52.103.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790F4685;
	Wed, 30 Apr 2025 01:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745975186; cv=fail; b=f3fBxaQpIVE4SShuBdrlNSeQxhS41fYtVWgYCjqY8/FrR+xccIVyx3t+2DBIlG80E59ES9KtFBTf5r0rX1PeULNvZp2Jlric1swUcRTahw/i9LZdvxcHLlooB5EvxNG1OfX9V34tUJwoeXMuE5ZNwRKg8DBUe4rGInngVA73mXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745975186; c=relaxed/simple;
	bh=JLGLrrsQt1c1UT4KofVslVTgUQMoxoYi3Hqbk6bQdUA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nsjdFM4/WFp+D0jQUYMMD7UKmJgM86yTP1w+yKHVWgwjKfqYtMEJH2qhZ9ekA+NSBw+Ul3a1hCeygAjPl9oMOSlFxy7jFn8bMUXL1u538BQAVqUh77Ox2f/Db2uol2nkXfTKi7/xqy1Uh0Y52APsnt1m4XDApeky6+l6kheikpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MeRhU1cx; arc=fail smtp.client-ip=52.103.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Es3J34Z8DhnT5W2xl0+mv0XJSM9hAJZ1TzsyfERZQpnUPo5rNILDuO8dzZwQj69W3JSv5ySaMxCedxg9IaG62iBPt3dPY/mo+2cxRb9Tk4THLl6TR2lOFyvzu0EC03XuPX5E4P4yjyLVsdlFpbScnqVmm2X1EkIrVLGtrZAp2auFX81AadS1rdZJuuubyY4ImXN0bn11ToN4mJMxetkUCI2GOxuPBbVbFRKOU9OVIHsxMBPSfompb1ODwQEIjKQHYLvxqs3LMC8aecziuAhbw+pjrszMtduR5pFGHi5l/5pKNRTPbLd6K6jzJ4lXPeUQOrzHZniS0l+EEb19Zt5c5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaxsN334xgnigdSkjzK/PBCZlnAo8NV2gJUqX3TH7Ic=;
 b=ao4eOdP2WDdN6foYgwyMW+qdk5Jj4uma8hJdyxqnGEZ/Q4OVxZRfsi1CsgEEpUBGcq+Hs1RHjfXfnbPMp32vFTHx7BswgrOExZnL7NgOv10+V5Q8nLHsXSIyYmZrYxFf1C4wueH9UopEmeTjkBIqBbzkn25TbxjpY+SzY1hJCiiN47w0jJrfAKqQSybYVXhK54gB6rDDul6bOmN8q9BGldcGMB+n01eWOcinXpzPuNeN5XUtRKjjEgL4COd+FgODxfmSbc7Tc1PmXz83GFjRoarX5Q+idhmRkikysqUP1D/9HLLNypEOrvwbAxykf/ZTn5PlpC0I4tCt8aU+suiSBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FaxsN334xgnigdSkjzK/PBCZlnAo8NV2gJUqX3TH7Ic=;
 b=MeRhU1cxyAfMSMs0xy1JTelrXQwD5a+d5UVkXziF1YOmQiF6vkLEMgbgK8UhSMF26uAhfKIuS41/nkCyacxlxAC6giiri80tLE8/qwt96e4yR4PDi/R9sbY9KjbiRq+MguLXiw77EBz2u5+v4xsGC6D9+N/k4Lb+Vkirkw8lyq/r4gNfC+5DX9MEaPKYQcPTeYKvhRIpkDw7zTqg2XX58mdUpW1jG8uf+UUvt85N3YQ35u0dX3Gf5sbayT+sM/rkSPrIsEoha0j3NPlFVQIASsHr/IUiuQLR5Jo6gsmDxLJBfOFy2O0J1d/oSvXMsUyU+I54bFE0FvI5oA7mUohF+w==
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:100::6)
 by PN0P287MB2097.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1bc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 01:06:16 +0000
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4]) by MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4%5]) with mapi id 15.20.8699.019; Wed, 30 Apr 2025
 01:06:16 +0000
Message-ID:
 <MA0P287MB22623E4996197710C08ECBCBFE832@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 30 Apr 2025 09:06:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] riscv: pwm: sophgo: add pwm support for SG2044
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
References: <20250428013501.6354-1-looong.bin@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250428013501.6354-1-looong.bin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To MA0P287MB2262.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:100::6)
X-Microsoft-Original-Message-ID:
 <e4b8ddcb-19b0-45dd-a2a8-fa7b403c82bc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2262:EE_|PN0P287MB2097:EE_
X-MS-Office365-Filtering-Correlation-Id: bbb65b28-4ee6-4da1-0ce1-08dd87833556
X-MS-Exchange-SLBlob-MailProps:
	obhAqMD0nT+Low/KBlUSJz3r0Ahd/UBo2ixQ4o5JTmkhsjmANm/rzUVmsYNxFDxkExK14aZzSPKWHJqKEW1RzMCrkGKofOQb9LtO+1vmArZiMwcOalXW/uvSLEqgK3JJSKCBRnMElQQ6z5L4pk2ngrMAoJO831wapM+dbSNEA/GgK6y7nMDyiaGWtoM+VT5QdclmL4Po7lkAhoGGqGzHpONDL/1sKFVanv/G9iCuaKm6o4YJ6ugDKpKuA00gsgoAZMp4tatGU4k3o+dhmcvJ/ZGgxne+8njfCGpBgcJC8n+8riaeB3WOaajiBIDy0y4T4seT3pnAMTPz333WAEk2A2ACvDJl7wA9+mhWH4Wo9Y3aXxTRvfCqs6PMApjp3vFtBmhetmQR8aaKgsi7EeQwv8RZlBMtDNImXANgr6aoGJfbf0BYK9HDRpG2ZH7w9uCJ8adRvviBsQUJBnbD566iJJy1+1ixhTt1VKIYa3s8N7t3jot8EXLV6ZIZEyn+PQbiHUa3DoB5+xfxnMtcsk5xq4IUj5sWFlvNUA6WfkVZ27Vs8NgJThPYx/HXA/PDYdAehezydL7d0Nf0OQkedUjMZaXAfFOh95KPRwdMJJzIcEdjq+xufc+0vs82gBGV9KbNWKpMpqgeBPCn5URRmWKkVSGCo3xwSYTX/O6DlTfA8phJqVlSm4XdUyXaDHVIlFJenR6aqcO3+NdWN7jUMsPl4OiyoVW8UrtCSFR9HbWuMEO4NzeGj4EikfGy0Fdi0+r4xM4dYSpVDj0sWWjAcgn7rbh3MhmwSUqs4+kRkPGva9SJlZFHx1PLG9Fppn2t60sf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|6090799003|461199028|5072599009|15080799006|7092599003|10035399004|4302099013|3412199025|440099028|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aElEYjNLVDJCVldiYTR4Z3dDWnhVdUdOcDMzVkNqQ1NpU3pOTXNQRmNHbTVx?=
 =?utf-8?B?TnJRYjE0MlRRQ0VrVzZ5UU81aTlNeklOaERlTnFvOGN0eVM4dytIUUkwdjFP?=
 =?utf-8?B?V2diakVEVXl2d0RjRFVibUpuQzh2M0lqeU4zU0pyUHR0dDNndmFlemFiRUlF?=
 =?utf-8?B?TUZZajhZUHJIUStJbXVvTnVLWkpPZWJseG9iQjBWMWdHTndPZzJSa0h5c2lS?=
 =?utf-8?B?YUVPN2dIM21qcURpWGZGM0JhOUloQ3pDMEcrMkdmSHF5U3hwRFlOM3U4alJm?=
 =?utf-8?B?VjllVXNhYmdLa244YUcyT1ZhZFZKQjRsQmFMdlVFTFhwYXo4cjF4dU9XZHZZ?=
 =?utf-8?B?THA2R2N6TlYydGVEaVBocFduVHJ3REFDTnhOQ3JkMW9JZjJ3dEUxTUhhaTBL?=
 =?utf-8?B?SjIvWWVwT0UxSGpIc3h3eFI5OGlvSHY2anZLY2Z1Y2hseFU3aElFMWpoMU1O?=
 =?utf-8?B?eDdUdzJqc3FqN2hTbHJNUHFlVE5qYVdKZUVHZGVGZm5ManArZXdlUUI1U01h?=
 =?utf-8?B?UEtheUdGNWNVdUtRSzFNa2NTSHVTd3dQN0dvM29GanZxbFNheVF3R1NWczdS?=
 =?utf-8?B?aUN1RWFZaVZjWGZFYjUzTGxsZTZkdUgrTHJJaEdkOTZ0dHRhTlNNMmNqUHRn?=
 =?utf-8?B?ZlJKRHlLR2RsbUFVMDBDWEJESEd0SnBMUjhienVqSGtLR2VuYklPdWRvWUpF?=
 =?utf-8?B?V2VVOXdQMW9za2lpaWpUdG9TVGJXdENndUYyTjhmSHlLOHN6S3lOZmhPVFhk?=
 =?utf-8?B?ajF5K0tocjlhK3Zyckh4ZlZNaSs5Z0lLbjZidGZud0VNeXlDaDFPeEpYMCtr?=
 =?utf-8?B?MGNVRUVjZ21TZEJ1TS9vOTgrVjlVRkNzVjcyMFI3TGY0SGFrMUh2OEd1b0RJ?=
 =?utf-8?B?M0JmSnVIbTBUcHBQSnBOY0wzck05bDBVWGlBanNaV0liYmNTc2FSYnc4RXln?=
 =?utf-8?B?Y0wyV3NUNUFBTnE3aWZrMVErY054a05MdVVEZmpyVmxkQjFhaE15T2hpNm1W?=
 =?utf-8?B?SHVkNFgwK2QyOGI0Z0dUbXMrcTBmNjJhQy9Nd1dLdHEwNlNETmMvTmFNWnFJ?=
 =?utf-8?B?cGdSRmMveDV5blhQcHpoU2FtdTEwc1NzNXRLZnNrSmtaM2dsTGljL2NwK284?=
 =?utf-8?B?TVNRVzRwRXgrS005aDczY1AzYW5jWkhUUzBYWlpvdVRhTGFNaXZBUDFBVEZR?=
 =?utf-8?B?ZlJuTjM5SFVMZENCeWpMLzc2WXEySS9pVDVVaFNDQkh4NnArM1ZDZ1NZTjFQ?=
 =?utf-8?B?OEEzcXNnNFZjNlp4a1hjSEcyZlpPbnpuQmFtUnA4aDliOVdHOTEySktsZkxr?=
 =?utf-8?B?NmMvcnhkbGpGQ25NY3dQQTdUOVVvRmxLdGRoMjV3K0hRMXdWczhuV0pqYUVx?=
 =?utf-8?B?azhQS1I2enBUdzBUZTdjS29TbGFFRTdwWFUvV1QvenA1S2k0aFhEbGZuUHBl?=
 =?utf-8?B?MUtVYnZhZTRUZzBEcVI4QjZBM1VKOE5HaUMvUTI3Q2Jjdit4Sk5ET1VaTUZl?=
 =?utf-8?B?bXJYaFJCZlNzZDZYRE9QTURCV2hubVZQUzRSZlVQa29rNk03a2NQbkNuOS8y?=
 =?utf-8?B?Q0RweVduM3ZPMW1ZV2RoNGE0NlI4YnI5TzNGTjdNNmVCWHJjQ3l2bmU1NTRI?=
 =?utf-8?B?QVdKMWREK0VDREVkM3NTekswUnR1eFpBVnJ5NStwcWN4YWM2SkRQUUNkdm02?=
 =?utf-8?B?dERnb1RPYm9aQ05QWHh5dFFDU0ZZUXo2QU5wMDFVTkpRZGNPanRzcnk2QTFK?=
 =?utf-8?Q?KJVCkSIDWJIBC2yiL3bGOapfW4O/74vW/VlgCmH?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTdodEZuQ3ZoNVJBOTlSaGtpS0xqNjhzVU5TWEVnWWpmMDFnSXdNNXpVZ05h?=
 =?utf-8?B?Y0ZtUFAvQ0poRkFuQ2VhNEhXV04vOUJ1NXROUWJ1R1ZyWEhhcmlIVitEZkpI?=
 =?utf-8?B?bHNEUlN4OXo3UEpHSkVubDkvQU5vQjZzZ3VUcHBkSG1aeWZndlZoTmx6VUZB?=
 =?utf-8?B?cldaV0lwWExZOEFCamt4VVBRb280b1p3MzJHMFk2MFBDUEI5MkFrd1J2YXlU?=
 =?utf-8?B?TWlBNlBDU2NYU3JkVnA3dVgyRDIxOHZSZlk0aDRrQ2pHUENDVC9sRlRVZGFI?=
 =?utf-8?B?WmxPQWZHdmQ5WWZvTE9oQTZjNk9SdFRrZmUvbUJOd1pWRUdITUJHVCtwRGFI?=
 =?utf-8?B?MFBRZGJHcXRrY1NqYkIzWm9mRVRhb3dGSG1RVisyVVRaL09BYnNzZU9UeU9p?=
 =?utf-8?B?NlVvNDI2d080OUVKR1NrVlpNcWZJN2RMc1hYTWp2Y1Q0blo1WkMxdWx3dnVq?=
 =?utf-8?B?TE02MzhsN0ZDb21QZk5ESm5HY3ozc28wZ3Rydi9pTnRjZGk1d3p3eXZsOGJr?=
 =?utf-8?B?N1QvL0wvV3JkQ3RmY2w5UjJ4bmhJc2RSNGw1K3dFeDNpOGtvSjdWUGVxVEFV?=
 =?utf-8?B?K1pSc1Jsb3lReWhXZDIzek16VUpycFZvRkhuMkdaTWZ5N1hjYzV3Wi9MS29w?=
 =?utf-8?B?MVo0REd6bmE4UGw2b05keHUyNDM5TFU4OWVsTHh4Ty9McGhWdi91TGIvR1FZ?=
 =?utf-8?B?NGZiQXhMSUMvc2g4bWF1cWhYdWt5RHFPbVA5RGdJaDFxTy8zcEFEekoxUm01?=
 =?utf-8?B?RW1OU1hIUDROcXE2M2NFYW55SURKY3FNMEFvNlRNd2hqcTJZM0xBUHZOaVl3?=
 =?utf-8?B?WDBaSVVBK0VOaTc3VlZsWkNkNTJkS1RkOVhXY3RZZTlad2ZrUnJITExUSU5S?=
 =?utf-8?B?RUVlR0RoVUJzbnkzcW1NckxnU1VEL2kxNE9IVUZudkVyZjhocVF3OWVFcVZF?=
 =?utf-8?B?MklzM2VMVitQVVovZ252Z0RnbUhaeXFvZGZKVzdkN2p6Y3JnbjV4MWJTZzRv?=
 =?utf-8?B?eW5PYUplOEx4UmRVOVRUZjJwSFRZTGVGUWdjNmJqZzZ6V20vRG9ZZ0RBQ0lW?=
 =?utf-8?B?K3dMU1pjeWptMzRTYzhuRU1OYU4wNjlZa1NZNGM3cEh6cXJhZldwazg3NEp2?=
 =?utf-8?B?T2hteVY0TURBSjhPL2hlRVE3Z0w0M0xDUkpWcFhDSlhjOXdUSWRRbWwrTlVZ?=
 =?utf-8?B?ZXpRK3kydUFpdlc4ck52cXB0a0dvTWpMYVJzQXlwOEFCdmV4NDNVdk5IWUpT?=
 =?utf-8?B?TGNLeW9kQ2FuZjBHQ0NUUnJmcTZhL0Fzb1F6T2xJOStPMUpmdVN4OEFaRVNN?=
 =?utf-8?B?YVJOYXAwekZ1c2dXNnBUZno5VVA5N0xXUkRsdjR6a01BV3lUVGJqSUM0QWg1?=
 =?utf-8?B?ZFVlOC9uYzYyMmozZXNBYXB5NjZkSm1KaHljeWh4L2VPbHQ4T2dYS0NYY29R?=
 =?utf-8?B?djhFMUtwSExnL01IbXdhZklEbWFrREhXa0g1T3EzSS8xQlhBdnRQMzdTMWZI?=
 =?utf-8?B?V1c5Yjh6UUs4ODRkRHFJTkV3TUxzcDB2a3VqclV5SW1PNkZUbThrNTRQTmZT?=
 =?utf-8?B?WmdrS2ROeG5JWXRBM3lxaWxKaCtqSkdPL1RjTTdQM1dzVTltQ1Z0TEh3ZVFY?=
 =?utf-8?B?SVpUM0NYYU45dGc2b3ZTbGkyTlh1d3dvZG9VbThIa1JUZ2JPd3hHR0o5SE5x?=
 =?utf-8?B?aCs4VEdSQWY4YU1vYnFnZzV2VGNvYmdaZWhrc3JReGpENjFmOXIvQW9Ec001?=
 =?utf-8?Q?/vu1HUtCK+UmA2TiDyTFFJc1XMK/t08rwlmp/YQ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb65b28-4ee6-4da1-0ce1-08dd87833556
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 01:06:16.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB2097

Seems only tag changes. LGTM.

Thanks,

Chen

On 2025/4/28 9:34, Longbin Li wrote:
> This patch adds PWM controller support for four independent
> PWM channel outputs.
>
> ---
>
> Changes in v4:
>
>    - add tags for mail.
>
> Changes in v3:
>    You can simply review or test the patches at the link [3].
>
>    - Rename macro definitions to unify naming.
>    - Modify code style.
>
> Changes in v2:
>    You can simply review or test the patches at the link [2].
>
>    - Modify variable naming and code logic.
>    - update "MODULE_AUTHOR".
>
> Changes in v1:
>    You can simply review or test the patches at the link [1].
>
> Link: https://lore.kernel.org/linux-riscv/20250407072056.8629-1-looong.bin@gmail.com/ [1]
> Link: https://lore.kernel.org/linux-riscv/20250418022948.22853-1-looong.bin@gmail.com/ [2]
> Link: https://lore.kernel.org/linux-riscv/20250424012335.6246-1-looong.bin@gmail.com/ [3]
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


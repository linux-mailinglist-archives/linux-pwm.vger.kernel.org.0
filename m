Return-Path: <linux-pwm+bounces-5396-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036F1A81D01
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 08:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4541B80CA4
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 06:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E7D1DD877;
	Wed,  9 Apr 2025 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="W4RUcBwQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010008.outbound.protection.outlook.com [52.103.68.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85631DB122;
	Wed,  9 Apr 2025 06:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744179922; cv=fail; b=Ai6eNT2mGa+XlQK/tfuVZK9+cpAE6Ms/J/qV4LbCSTQK7v2dFjijTlSS2NlpURsJDXIEeJJfh05B/cDHmS7ez/Y3py2jiy/BYYCSsOuMVLC0tcc+whqA8oSMzrE0eO/1woYpl+JZYOF9Adu5ycMuTvjOdVFMxIoitMHVXU2Lo0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744179922; c=relaxed/simple;
	bh=kCV6naYGiw0yCsCZ9jmysNJjdU6d8qMV95iiMBsZ4xE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LHG9ISNtgvatekVRaQ69gS9UixbXO89IWdrD7Jz1azaXyvQTTd4i2WiMZEkO/V+D49Geiw+2MwOyb5KZu0hW8DjR9if3PuvHT3qntSoT+zqWNh/eXV45lvrjhCozQQ7RFc3I7b6hNOoSmFgw3e3SfU3xD8P66zgxRLmLcSsukvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=W4RUcBwQ; arc=fail smtp.client-ip=52.103.68.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WipHWxvbb7lOfXMlaN8S8DFEfodxxbad0aXtZPXw3QgBo0oIfDck4Vj/VNNN13GYl9OYirwMamZn62BOBBjWBvMHu7iCbggSno4sODTvG+2ALi2gjH0MTTkDf6+1/vwpoav9U1Hb4kFbnAwEOtQnZ3MB5mEVAxeMeF1MDbD7+EKbp49SQIkanV+6y0eBp6pmkk3muGeYB2okFM5yVG1zrXGhtZwOO4XpVYVKjSjsxfhfNSxNGhVmzH7jy3U6aj+W13gbifObspQLV5mXc2p5Yo7Fm2zHyhYdHL/iPHIyFvkZDlJNoCspyF0Vv1cGtPtLGsgzfujZKpWAO9Cyc8r4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZkcqXIw9qXC1Mfc6OpVdlSuEiBJfsD52Ej4tUIyb0I=;
 b=Em91l5QSH9pxvQMGX/D8nZQxochxnzaD/zJX/tc70uscR8yJLTUYxAYoPKdYxbadFSV7KcRgz/reYiXKKqyBWxtDIM7JvyVHCiFqX59J5aho8Je9ksOBHi6D6br6PHHasoiy09vH4zsqwtDWnF8tQBy7gtWfjXEsDD23CvTbTTsaqayp9vk/7tSo2PgDVPUdCbJotpkVK1SIWb8MAPXOt4WK/f7ORO1esYDbDvLJwGySOUwT8fb7QE59a+5Lv6soIPI6YkDuYn0At25X4fH238SYOx8Oj182fxtcshrcuyt835kQqfkWFSc4XwH59eEPnGpsmIvlgPVczAJnEuGXIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZkcqXIw9qXC1Mfc6OpVdlSuEiBJfsD52Ej4tUIyb0I=;
 b=W4RUcBwQ9XR4U7Cs/cXQuxzelQ4z2i/x6hGkI38Iz7VEXLh6sUlVe00wi56O7fC0dFEoZjRX3vQt4Lz9IcVGDlIoi5AE25RMYWExzJrxVN1/NzsInoUjh0wnesHdycvbcr4g/DhcPgeQWqxZaBMaHsGqsKVknEXKOvdpWqKby3/XulovYUEaLf5c7ZqRD34uMlLq5NgDctPWfrgkECxXsnBPlsdVHG6fiDS7AuKNH5VKFJWWbVaU+7WO8yuPLfEEqQWEvU3gUBJYdZHZDQ50FT3uOJxPO2y7Wmgm5nixN4o3AVQ0hVmNSja6RgymcFmTGJuPWFoye04ITlhZIOG5+g==
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:100::6)
 by PN2P287MB0984.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:132::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 06:25:13 +0000
Received: from MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4]) by MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 ([fe80::ca81:3600:b1e4:fcf4%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 06:25:13 +0000
Message-ID:
 <MA0P287MB226270BEC9AD175FEB28E0B5FEB42@MA0P287MB2262.INDP287.PROD.OUTLOOK.COM>
Date: Wed, 9 Apr 2025 14:25:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlan@gentoo.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240501083242.773305-1-qiujingbao.dlmu@gmail.com>
 <20240501083242.773305-3-qiujingbao.dlmu@gmail.com>
 <k6jbdbhkgwthxwutty6l4q75wds2nilb3chrv7n4ccycnzllw4@yubxfh5ciahr>
 <D8Z4GLQZGKKS.37TDZ7QBN4V4N@bootlin.com>
 <CAJRtX8S0Zg7-Rba6ziaAoBi-2Bs3N0NfpguF40T16yObaxCZiQ@mail.gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <CAJRtX8S0Zg7-Rba6ziaAoBi-2Bs3N0NfpguF40T16yObaxCZiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0030.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::15) To MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:100::6)
X-Microsoft-Original-Message-ID:
 <45195511-425a-4259-87cc-52c6c7fb55e1@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2262:EE_|PN2P287MB0984:EE_
X-MS-Office365-Filtering-Correlation-Id: eb68cfd5-e38b-4a60-89fb-08dd772f495b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599009|19110799003|6090799003|15080799006|461199028|7092599003|1602099012|440099028|4302099013|3412199025|10035399004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WTRPMkpCdldSd09jRVJocWtoZUN4bTVQQ3c3UmUwcU9lcFNKQmdSbG8veHM5?=
 =?utf-8?B?dTRyR0hVMkZmdllOb09VY0RUMElWMFIxZ1Z5TlRmNldJZjlHWDBDNWNtNXo1?=
 =?utf-8?B?a05CWE54LzBaVnp5R0lVSHg5TGswSWU4bW4yRmtyYmt5UWFSQWlBSU4yb1lz?=
 =?utf-8?B?eVhxU096T3FWOXhBdENSbUZ5bFZBNkdGU3JoQ3RQMVVGUFpUZWRYS3p4WFNM?=
 =?utf-8?B?aXltZ205d0tndWJVK1N5TFBxMHQ3WitQWDRzZys2R2UrQThtaTlFRjNnd3Nh?=
 =?utf-8?B?QjdqNW1FUTM2UHRGOHpydGFBWFo1STZBU3V0OVJ1UUNkTE1BdVVrMnFLc3g1?=
 =?utf-8?B?SzBNVGYyRkNjS1RsaldVRFFKKzBMV2toSXltL0NtazR0S0Q4V1JOL0p0TDIy?=
 =?utf-8?B?UzVuODByTEJLcWlSZUEzR0lIOUF2eWxnNWM4K0xoSjI2ZGVXVHJIcVdnd3ZQ?=
 =?utf-8?B?ZHJ0dERFRkhqL3ozYjV2YzJqTU9xdXJOMlB2RTlodjRkZVBGYTVwQnNBVGJk?=
 =?utf-8?B?RldZVlRrTG5JUjBZa0VSYWUwcHRhSDhJY29wZzVBRGtPcFFhZTk2MExJcENx?=
 =?utf-8?B?MlM1UVJXMDZmNDZGTW9wbnBNY2lkSkw2NGxpNjVKMFlsRkxMeXExUDhWeUdV?=
 =?utf-8?B?NFBqamJFMnhvaXAxNVdQbVE4d3huei82NDg0dmdQRFdnWmZ1cWY2RmJZNkd4?=
 =?utf-8?B?WGEvYVdDVGJwbWZyOWJzMVp2WVh1ZDVYWTlJNitpNE5oV0NWYS9TN2dYK2gz?=
 =?utf-8?B?SGhsejFGTmExaERaZUpxMm0xTFgzRjZwWnQya1hySVVuV3ZGdkxvWCswNXRp?=
 =?utf-8?B?ampQcXFVVVdzSFlUTmNIeWcwZmxjcTRRRFUwSDh3S3hYMlJxTm42cVM4VWd5?=
 =?utf-8?B?K3hoZDBmdTBhUWZHSXdRcGYrcE04ckRIMlhXSUdFeG9DWDJ3Zjd1eWxkTGZE?=
 =?utf-8?B?S0xrNGpwZWMvUXloYit0ZkxLVDd6WDZlR3hDakVSeTcrYVlQbzIxMDVXVnBQ?=
 =?utf-8?B?RWJFeXM4V3VTM1RuQ0dqR1ZlR0J4cXVHUDhCSzJhUStPWjlFSHRFZFpvNlRR?=
 =?utf-8?B?L0thV0RrQnJHeVl1TDNpWlFPYjcxcnlLaWZXa3lZWDdpNmNlV1pNSkUwMTNZ?=
 =?utf-8?B?RklLTFE2VVE0eGRNMWhIbEJ6QzBVaGpyOGJFVXg5WGZHVzg4TmRRY3RHK3Ur?=
 =?utf-8?B?WnNBckVpUmQ5Tmx5TTV1dk1IdS9jOXltemlodjZDSEF6aUd0Y2w3emUydjIy?=
 =?utf-8?B?d3ozMWFBMkYwVWhNY0lubTNtdFJPeE5XRnZldmpuL3RHSUlkR3gvMk5NeDhN?=
 =?utf-8?B?MXZsZTJHVEN2MC8wRGFrRU5nMjZleTREZ3k5UjJvRDFnTDhIeEhuWGFYNzlj?=
 =?utf-8?B?NlgyMDlXTUw2N3RLaGJoU3hkd1JaTDJaMU5aUXJFcVpUK2djd3hseGRFQ3hx?=
 =?utf-8?B?Z0Y2dnlOakcrYWZkc3RybWJuL2pEZ3hFRkpJc3NyclBOZWk2amxSODNVZ2JY?=
 =?utf-8?B?N29STjRPbjdjaE9ZeW90UjV1c0NFVDNaaWVGdk1sZ3dGbldOWkYxaWlUcXA5?=
 =?utf-8?B?SUtxR3JzTmFtdFJzL1QrSlJHTDMrYjlFdE82Q1VUWVM1a0Y2VG9QajduR0F3?=
 =?utf-8?B?anlXQmFVaHhnbklYM2xaSVk0UkNtTEJuTUx0ZmIzbmdLOUswWTVvb1ZlNmlX?=
 =?utf-8?Q?8Kj6E+WNEwjPU8cJn6Wp?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVhwMUY4VEc4QkNJMHh4aEJ0eXRuWVJmbjZNc3E5TWJmM09HWStaQzhuMmg3?=
 =?utf-8?B?K0tiL0lDSzNCUnNxRkMrL2xhUXRSNGUyOXNPZ3VTNnJJbDFGeURHbUtONWF6?=
 =?utf-8?B?ZnVzQkpDMnBYZU9HV1RIbEZlT0FWdWQzVFQ1SmFKbTVrNE9zaWpTYVp4emdj?=
 =?utf-8?B?MndZRjUrSDNteXhHNkU1bE16aDZsSURTKy9nTGNLRmVIUUsySlEvNllWd0kv?=
 =?utf-8?B?YnFUTDZGSE5QWDVmZ2lhaWJ2bW1yanVDVUlUb24wTHlkVGY5c0RWNE04VG1E?=
 =?utf-8?B?Q05ET05wQW9GUUxza0s4RnFLUVJLbGwwSm15bzRQdm0xcjlFMXpCejdFbzZ6?=
 =?utf-8?B?b0wwMnJGRkFBVk9udjc4UitOSWxQdVZ0MUtTVUV0RlVOdUU5ai9HU0FZdGlE?=
 =?utf-8?B?aFdTdVVtUlZRQUZHa1E5Yk5EN3YrM3dOWW9nclg1UWJsTExzcU1CalQ0ZjNZ?=
 =?utf-8?B?bS9TL285Y3FPcCt2cnJDc05vU1p1cFoxYXhSNDVuakdHNGMxSnpmb1NNSlZL?=
 =?utf-8?B?U1BvWDh2Z0hIekwxYnM4N0ZUMGhoZFArbXhiS3RlTnV4Y1AvZFRBUDEvcGNI?=
 =?utf-8?B?UGFoNkdvWUhOT21KN3FNVm5xVHZMcGdmWW96VURSR0QyU3pwcE9DeFBjNHow?=
 =?utf-8?B?Ymh6dXBjSUJvNUFxME1WWUpEOGlJZ1JwaER0QVJTL2hzRCtIUU9oWmQ3K0FC?=
 =?utf-8?B?amNZdXQwZzFoU3EzRXdvclpUWm9ZRjBqeExrYXdwMnlwTzVuV0YzMnFCVXky?=
 =?utf-8?B?L3VMSmZDM1NPeWs4NHQxR1NjMkFieVZXbVhsM0xGdHdXVnFzSFF0UDBWZUp1?=
 =?utf-8?B?aTRiazZsWGdiNFFTdWdYdjVWQUltT3FuOUFmWDRNczJydkFnaUdRVW80ZTJx?=
 =?utf-8?B?c2JkV05vWWxZNlJhQTdDRlhjOWZuUG9iRzBzaVdCVm50WVAwZmFlNWx0c05u?=
 =?utf-8?B?SXJhd0dRWTU3c0lTV3JaeERnbmh4SG1sMC9lOEdWTmNRVWROZFAxclRRRlA2?=
 =?utf-8?B?OWJKUjloNHVPTjRqaWtwNmFrVHVaaytIeDVKTlN1Y0Jyb1d0RzRwZWRIRWhp?=
 =?utf-8?B?RUw2U0k3TktlMVcvbHBHN01PTlZjek1BZDQ1eThQeDdGS3hUOXZKZXhsNEpD?=
 =?utf-8?B?NjkrajdibDZOb3Qwc3NERzUyM1hPOURZZ3dyem5xRWpHOHhPTlJJZDlBcEhP?=
 =?utf-8?B?ZjlTOFhmQ3lMd2FvR0tVTllvTnlWRm9LNUs3dDNQQkdPK1BEKzMvT0hiVWJh?=
 =?utf-8?B?Nzd2blZBeEFQdHJUaFp2WGtHVGJHWGhMNHd1MGRzUDhsaHNKZGozTlZyQ1Bs?=
 =?utf-8?B?YXVQQW1EejNTWWRrZGgrSVZWSE1jUDlzQ2R3RkxwTSt4Tm5YbENFbW1pYlZX?=
 =?utf-8?B?YjNncEpOUWlwSWZ5TjlJN1RROWNOWVhBVE9MSjN1ZzFSVCsxWnFNcjBUYmpo?=
 =?utf-8?B?bWtlQmh0ZCswT0ZNNU1LVWE1YU9JQWMxdHhKSDZmN2QxUWRsM2RTVkJneEpo?=
 =?utf-8?B?VjJqSDBnNGZzcU1GR2pIWXE3cFZJT1huN1dNVVJKdUF1NmMzQ0dPNERHd1VF?=
 =?utf-8?B?YXRWUXQvL2NWaThCUWJnUUtYL2dJZHJEY1hkNWZjSXF1bHRjR1hJQXZsWHRP?=
 =?utf-8?B?UTh3N2FURmJLWGlUL0l4RmhpMTUya1Z6WkN1dEZvOTBmOEdZYlFmTUJFczZH?=
 =?utf-8?B?QU1XcXpBSXdUak01MlA3SjBXSzFnMXkrVERZd0NyQUZuKzVUOGpWajlqRjN4?=
 =?utf-8?Q?jz0g7p7BRfYxtEImrCetuDlGGZhyc+2Ilmstb20?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb68cfd5-e38b-4a60-89fb-08dd772f495b
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2262.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 06:25:13.7124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0984


On 2025/4/7 13:38, Jingbao Qiu wrote:
> On Sun, Apr 6, 2025 at 8:16 AM Thomas Bonnefille
> <thomas.bonnefille@bootlin.com> wrote:
>> Hello,
>>
>> On Sat Jun 1, 2024 at 1:53 PM CEST, Uwe Kleine-König wrote:
>>> On Wed, May 01, 2024 at 04:32:42PM +0800, Jingbao Qiu wrote:
>>>> [...]
>>>> +    if ((state & BIT(pwm->hwpwm)) && enable)
>>>> +            regmap_update_bits(priv->map, PWM_CV1800_OE,
>>>> +                               PWM_CV1800_OE_MASK(pwm->hwpwm),
>>>> +                               PWM_CV1800_REG_ENABLE(pwm->hwpwm));
>>> This looks strange. If BIT(hwpwm) is already set, set it again?!
>>> Also if you used the caching implemented in regmap, you don't need to
>>> make this conditional.
>>>
>> I was testing the series and noticed indeed an issue in this driver at
>> those lines. If PWM_CV1800_OE isn't set by something else than the
>> kernel it will never be set and so, there will never be a PWM outputted.
>>
>> Using :
>>      if (!(state & BIT(pwm->hwpwm)) && enable)
>> Solved the issue but as Uwe said you can probably rely on regmap caching
>> to avoid this condition.
>>
>>> ...
>>>
>> Do you plan on sending a new iteration some day ? I may have some time
>> to continue the upstreaming process if you need to.
>>
> I am so happy you can continue finish this patch.
>
> Best regards
> Jingbao Qiu

Thank you Thomas, I updated info on https://github.com/sophgo/linux/wiki.

Thank you Jingbao too for your good job done.

Chen



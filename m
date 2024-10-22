Return-Path: <linux-pwm+bounces-3751-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ACD9AB754
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 22:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59AC1C236CB
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 20:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DDF170A3D;
	Tue, 22 Oct 2024 20:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="NLtTUoe0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2096.outbound.protection.outlook.com [40.107.103.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D818713AA2B;
	Tue, 22 Oct 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627335; cv=fail; b=azDS4m7lHEGqiJ6kL7x14026WcKsfjvChh7CNUbmPHZ62n7JlhkQBnWEhk3JQrjqctNeUZC9C3Zisp4iwlXgVL/CITeH3f7mFer7+xF4Z77KK2xO0jh+meTc+KLfXtA94AQTHKnkcY/gW5Hvp7ikS2gNH4EeSCetuNfmCCsnprE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627335; c=relaxed/simple;
	bh=fnjaBZtqrXb9H4hbb0lUPaG2MTUKsLK1WVYKcfV7j7w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Azgw/UeaI4LEHswX307YJOfBtvmmw5r4XIu4LD0sKtXm/sUjGIgXTi1fpoWVUjd/FztE1iEyYGIn0P7H8cDfUZIS+LltJmqUKHD4ezvyQwQF9bzZddWy9r+7yEMF1GYEQPcFpGPw2rikTkU108kwSDn1NjRyXtab0iqEh7PKyvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=NLtTUoe0; arc=fail smtp.client-ip=40.107.103.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxrxmW87T4/JHAW0ZsxJaBP7rWCU3bA3WX4lC7g33aXMcarjU8jLQ7igYU7zmFwuUNg8FfN9gV+dc3FGFT/vuMJoCijB+qkVoUB53kzaiRRv93VuFMVdzgUpaeo6UDiJqydm7ccX0qH4yaiivnl1Priyg0u058tfd33B18YTq56TjUnXsMrToix7Qftgo4NSbG5wzlHsdgYddTzLwsa9IEWIxuDVFLkI8maXhpTrQiZdA1Ket2fvFGTFmrbHS7Jtf/gQa/0+jYPngW85py1fZbzegKnUGXRukbw/O+ZuRwY56IzPvu5FA6+kQentIkKU2H2QQ9gU/dcBp/PwOcCm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87RcKhJDs6FlRln9tzoxOSMCcmjK517e2nZAx4ewQe0=;
 b=uxtsXWdaTrs0zwaPIFpUDzPTH1FA16aSgDIwlHIMvPEoNIkYCz1/sDpHYD1KNc5OeNjYBZQ/6OjMZoxqzPy3SJpRIdTmuze941ah6h1ejVIu6SRbhpLf1UuKObZ1SSjea6wjQuNXuwABrmmOMI4rYXe7CGMgZE1xzBC39N9S23qKN2BIPGAO/qmrnwRfTZTXaGoQ8aUYwo3j8FL+83mYmXrooSmd28TiLNGHgJcGfnyY2OlpJRezUF3ZJ8eBFT+VD0Ejh5HGj2B+B5LEbaUSuM9mJyt7VhCjq/I8hlIwGSSAfq1WYq8HzWbJH/UZCsfQR7Gy+mh29woekwuX9fyiQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87RcKhJDs6FlRln9tzoxOSMCcmjK517e2nZAx4ewQe0=;
 b=NLtTUoe0xg2F9lzTftjJiGrPKfr5bdAUiOJogz+5t3fTKKOnX0KcVmamQSSj4yyDZ3q2Xvz3LQ85P4tX2hEVbza7bZkFPwTFVuan6BgYLM7p8Tq+I7xsQnBkzjRSntpD/a8pFwBix12wasWj3BT88Q+P+3cgSl4rdp+Ya+ddgA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM9PR08MB6034.eurprd08.prod.outlook.com (2603:10a6:20b:2db::18)
 by DU0PR08MB8188.eurprd08.prod.outlook.com (2603:10a6:10:3ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 20:02:07 +0000
Received: from AM9PR08MB6034.eurprd08.prod.outlook.com
 ([fe80::9ead:b6bc:10eb:ef35]) by AM9PR08MB6034.eurprd08.prod.outlook.com
 ([fe80::9ead:b6bc:10eb:ef35%6]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 20:02:07 +0000
Message-ID: <2da79425-0cfc-4c73-8fb9-bd3c92aa28d7@genexis.eu>
Date: Tue, 22 Oct 2024 22:02:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/6] dt-bindings: pwm: airoha: Add EN7581 pwm
To: Rob Herring <robh@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
 ansuelsmth@gmail.com, linux-pwm@vger.kernel.org
References: <20241018-en7581-pinctrl-v8-0-b676b966a1d1@kernel.org>
 <20241018-en7581-pinctrl-v8-3-b676b966a1d1@kernel.org>
 <20241021190053.GA948525-robh@kernel.org>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <20241021190053.GA948525-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF00014AFC.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::30f) To AM9PR08MB6034.eurprd08.prod.outlook.com
 (2603:10a6:20b:2db::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB6034:EE_|DU0PR08MB8188:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ed2a96-7b55-44d5-3061-08dcf2d4682f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YW1zMTJtTU1vVmhNY0M5aFcwVEZjUDlueVhRTGdMaGFLSkVQR0J5UmF1UWpL?=
 =?utf-8?B?bW1pN2F1V3grbEN6cGpmZnpjbVZsU0pNejRYVFZPNFlneGhPNlRSOC9JRW4r?=
 =?utf-8?B?TEs0TDNLNEpEM2NHMVZlSTB1TngyM1Fid29hcHJGOEswR0hNbGpFYVNldUZF?=
 =?utf-8?B?M0dKY0IwRjB1TmZEOHN3ZTJLWVpRckdYeUFjTHd4OGlRWjAzVklaRWdabTIz?=
 =?utf-8?B?SEdhOUxIRHZZZTVtMlFkSmlYMlBSbWdOcVJPZmROL2t6dHZMTFZPTHgzUDAr?=
 =?utf-8?B?Y1oyckUwSTd4MU02b0xObXF6VDcranJSNTVvc1l6S3RyTnRXWHZ0ZTdyeG9C?=
 =?utf-8?B?SlVET3RxQkxRSGh5MzlINnkySDlNRkg3eG85UGJVZDdLN0pLMkkzdTVYSElx?=
 =?utf-8?B?NlJScGY3QVpmZmdXOEplMU5ESytPRlovUmRjMFFTQzJQd2lkS0I2RENoSWVK?=
 =?utf-8?B?N2I4RGlXVVFGS01aZEp0Vzc3c1BHM2NjSDZVOTFrSkZlaVNmWTI0dHhoNXpv?=
 =?utf-8?B?eGc2SWorZmorMEhIZkdsazdDOCs1YUh0aDIzVkljZmtRbHlXUjQrUnpMV2tz?=
 =?utf-8?B?YllZL242MGxoakxuYzBnSzFBQmZNZ1dpMGFxWllyV2tTSER3b3AySnBsdWwy?=
 =?utf-8?B?Y0kvSm5aRnA5QndzdkJkM0ZremgzYWZWUHU0cHhrdVpVY3NEcXhuWW9Od0U1?=
 =?utf-8?B?b0MxdFlHdHpmdzNBbGt0U2Rub2JIVTNmNnVMeWpld25aMEovbmw2aUIzZlpW?=
 =?utf-8?B?bmhKYnBLZHZqZitMM1V1QitiOUlXWHNBQWxROHptcmwyVkxmcWVVVGNTVU1F?=
 =?utf-8?B?ZUJHNVFWZTFDWGRZN0crelFOb05zNENnU1EzeGZZZDVVa2hrYThDNG1weGRN?=
 =?utf-8?B?WVR4d2RtQTQvYlg0R1MyeW9kSkFJWHNTakRMM0o1aTByWnNIcnFoV3p6djZX?=
 =?utf-8?B?MTRIZmtuZUIrazZSSE1lUUJtRVRmUmJFRndCQk93Smd4Qkt4eXpkWVRiOTBM?=
 =?utf-8?B?bFJSZjBDZTlQdGN0S0o4R0ViMllaTmV2bm5ma0tpUHBWd2FzZ2pla3NCRjhC?=
 =?utf-8?B?T3JURzMvYVF0UnNuTDdndGZUYzhiaEtpL1hUODd4cWxHQlBrRjZTVHRDaFU4?=
 =?utf-8?B?Zm40SDY5MFYrV21ONEhDZlVNdlZmUUxhSTRUc2ZPeGw1L0NyNHZGNm9RZWdl?=
 =?utf-8?B?MWtWNk1xVUl0NnZjWi95Smd0R3Bac3c5RTNPcC9YWXF2TU5kWnVXRGJ4M2Fr?=
 =?utf-8?B?aS9QYzdqcDJvZHFQbkZTT3Nxb2laOElzRTBIa20zblZhTlBWK2FwTmdKdW9S?=
 =?utf-8?B?S0pLNjBmSlEwVkVCeDFxZjNCdEFSZGlTMzQ2SDRnYzJXVGNBc1ZDdEtLaFRp?=
 =?utf-8?B?UUZObTl4bzgvMDJPUlhvNmtiOGhDVlhaRWRyZlB0NFlPcUFVNCtFY29ZTGhq?=
 =?utf-8?B?TFUvdU9PbXc3cFZlSUJraEExT2VFa0crbFJjNHlPaDRmTk5JcVBWSVU5MkI4?=
 =?utf-8?B?K3RSZm5rRXd2dnpHTUVRb3F3dmlSTmtweFRFZDFmM2Vzazk4Y0JuMlRNVDND?=
 =?utf-8?B?aWJlc1UrUnBlSkJoT0F6emVjN2kyL2hvL2JXVnNuS2pjNEFmc1NUeCtUcFdL?=
 =?utf-8?B?UVYxNHNaNmZjNHFTbzVkVUFpYUN4UGV5RVdzV20zZUVCSkJxWnhSUTNEdTBE?=
 =?utf-8?B?K0p4WVpIcXRLa2gzczF2ZlJQb0NoY0ZVM09hQ1hNVHo3UnpMcHZPUnN3RWRN?=
 =?utf-8?Q?A0PoeoUdzXt7XeIlWY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6034.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFlVMUZLWGpoZ2hKN3hBV1J5SEsrbmRFMWdGM0hUMjEwYng4Ujd0UWg0M3I3?=
 =?utf-8?B?bGRiVEt5RGkydjlFY0ZYNk5wRTUxZnQvMmhpZHU3RFZOc1FsZUlnanF0VzJU?=
 =?utf-8?B?NnpWVVovV0FROUR2aFR1bzRvMERXNVA4M0tUcGxYMitvYmpTSUpJMzFPVXpz?=
 =?utf-8?B?R1BGTm1GRW5MVkxzcG1sZW1VTlF0MWJZVTJ4MUZBcU1IVXpwRVhxU2FKQzlC?=
 =?utf-8?B?SVdaWkhXWDhHTGdjYVdwQXB1d0lmbEJ6eXhSem5pRm5KMGgvY1BCQWw1MVoy?=
 =?utf-8?B?d2xKVE12QitXRzNYS3BuMWROMDZtSjNBVVp3aEIxMUU2c0xQQzVidVVMaVc1?=
 =?utf-8?B?dStsN1VUeUNZTGNnRnc3UXpuSGwrUTlsWmVQalJTb0JMUUY2emxBdW5LQUha?=
 =?utf-8?B?N0twYnZvcFF1b3o0aFo0clY2VUtlclAxZ1RrZjNFMFFhclE1RVNVc1NYMlI0?=
 =?utf-8?B?VWRDOFRTb0JKQjVsTzFLanozeU9MQms4STVXRlM2VGc0VnBWSEhsMXBqc2lk?=
 =?utf-8?B?d0hmTlRYNWsybHV6VUphMGw0THlHbzh3NjBnRWlkTHdnRTZnYnJGMnlnUU9C?=
 =?utf-8?B?MWpjNjZjandVbTRwKzV1T2xaWkl1Q3cvdnVETURGRkdzZnZ5WmtRNms3bkts?=
 =?utf-8?B?TWlkdndMSmdiVEg2S20zN1JOWTEreFN6cEFYOU1KalhqNzIzbnBzeHdLMk5j?=
 =?utf-8?B?NmphZE5DVHBTS1JObXhRbm9zeDZhaGRrSU56Q3piOHNJUmEzWXc1WEhCYzI0?=
 =?utf-8?B?WnA0WUl5eEVDQWduQVVsSkV3RHN3M3RJdTNuSkRncFFEd0dvOHk1S2UwTllC?=
 =?utf-8?B?ekhiaXpwUlhJem9XWmg0ZnNVV3B3L21LOW9JNnBIRUJWRWNieXZKMHB4UnNo?=
 =?utf-8?B?RU1neVlpUmc0Nm9oYjNOT255R1dkV2xVVzZqN0FXS0J3UnQzeS9KTmliRUEw?=
 =?utf-8?B?Qm9pdjd0TW9Oa1dKSEZhSkw1emxLT0xTTGRpZzFOcVgyR0tTZE04S3c2R2Fw?=
 =?utf-8?B?WTlzMEc4REhCeU1QV0tsd3R0cUd4VjlpUnE5Q05QTTRMaG1GZ0tvTG1tR3lP?=
 =?utf-8?B?RkVnYUJHamZYN2ZvcGRqUVozOGN1TWtyU0lOM044bmk3R2t3dVV0MlZvQXln?=
 =?utf-8?B?VVQwNDBpdlRSM2orNE1JaldDSFh6cmJRUFl2WXZDRnlFblFKdzE4NDhYNzl1?=
 =?utf-8?B?Smd2NjFqRGlDWEhPcVJidVA5a05GWG9VUHNxWnQxakc4LzJ0OG1jcXRqVG1P?=
 =?utf-8?B?cEJMdktoQk5wTnVPRk9pTkxqTFFyZkVVRzR0cWlwUTg4NHdaTGcxOFV5QnpD?=
 =?utf-8?B?R1RmMXA0eWpFMjFCQjlVdDBLT0ZKc3BqM29RaCtkbFNXV2kyREZpcDhDaHB0?=
 =?utf-8?B?bzZSQ0xpUE1lRkVKVmNYazgrcXNQd3R1MXNCaXJjYW5WbHRQV3FHSFpMaFEz?=
 =?utf-8?B?bGJlVEJKMkhWRXhPZjZHR3MyVE5lS2laV2FWWjRTWHJRVHl5YjF1dzB0YkNv?=
 =?utf-8?B?cjFJUVhSeUx2bThoODdnd2J0SitaajVOT2lhNHRReHBtOVFSRUFOTDUzdmEr?=
 =?utf-8?B?Q2NUVVlFV1BCcSsyVEgraFBBM2pEei93MUt0VEdia0Z5R3hkWm5TRFB3Wm5Q?=
 =?utf-8?B?NGcweGFuTjFDMzFaUWlJL3JlUllLNEo0WVVJVWVVUzRFbU1TSEJId0JBQVFY?=
 =?utf-8?B?ZUxwRWVGMEYxaW9jMTVJdTY5Ylg4UUFBQ3NyTnJVVlRGdk5mMHFJV2FUYUJa?=
 =?utf-8?B?RkdLSlRucjJYU1oxdTc5V2ErQzcvem80N2dkV05MNStlZWZDcUZoQ1N3RUN4?=
 =?utf-8?B?UWNzcVkvU0xTSmwxZHg3Ylh4MWduU0tUajJIRFU2ZW9tUVhHbkRGTDNldFZ6?=
 =?utf-8?B?dVJKOGRlZzBJY1VsdGtnbVFYVktkWjhOamxSUTJYZHlsMEJzSVRoVmhRYzB5?=
 =?utf-8?B?ZndHaUhpalRWbCtsblpmRDIvczVYWXpPcXROalRtTzRhRmNESmZxZVJvWXFK?=
 =?utf-8?B?dkhDajlzY1Z4TjNvT2tBeGdXRnh5UzlWY29uVUZwaksvcnA4bU1XWUIzNXFB?=
 =?utf-8?B?TmRFQmJZOGR6VDk3a3BWZGF6MVptNlZsejFTQVFHc2gvWFBVSGRZQ3F2VXlI?=
 =?utf-8?B?Y1V6dnpyVDBveFU0aER0STQ2cm9jd1BVR29FTWh3Um5oa1pYZGQzSmQ0Q1Fa?=
 =?utf-8?B?SlE9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ed2a96-7b55-44d5-3061-08dcf2d4682f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB6034.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 20:02:07.6242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cF3nrnuN3j2DnYsxPY8NLbe+VdSdPX/LjxBLIv+IEdpQ+ePgzxzrGUKItgdOUSw7RxlE7LpIvBi3XUQ6NCg/LLCHVYaMURJqtEbsIP5e6u4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8188

On 21/10/2024 21:00, Rob Herring wrote:
>> +  airoha,sipo-clock-divisor:
>> +    description: Declare Shift Register chip clock divisor (clock source is
>> +      from SoC APB Clock)
> Where is the clock source defined?
>
By measurement the clock was found to be 125MHz.

MvH

Benjamin Larsson



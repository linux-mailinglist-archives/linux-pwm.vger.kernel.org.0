Return-Path: <linux-pwm+bounces-8404-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM2UANfeyWnM3AUAu9opvQ
	(envelope-from <linux-pwm+bounces-8404-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 04:24:23 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6F1354C69
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 04:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BFF83001A68
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 02:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAB1391848;
	Mon, 30 Mar 2026 02:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dsl0oNc7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013014.outbound.protection.outlook.com [40.93.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE80207A32;
	Mon, 30 Mar 2026 02:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774837458; cv=fail; b=GcYTUPB6juvZxflVnQXrRpbIHsXvHMPMg5lzM3BzYBW593tz/U+Q4l9k97QyvpjdHj6bu1DJDAX9rClgKCGTH4JbEl6/yjW8CvjmA90f2cCA4VJlQn4d+r5EuP7l3qgg7wfTOOfY7zoz26Gxqnhilc2LLl4bYNAqFZxFWYGvQ7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774837458; c=relaxed/simple;
	bh=4Hyo6wkYRM8HGSDNdtmZjG50hivxW2NYZOlJBFExsF4=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=A1OgAVNu609rvbu6SITKPhO91c1t+ynznwSRz/nKaLRBfWTbFm1eAbMgHjFrEGIqGPwZi9Q1DU5J3mNu9u0uGhwc1ogSnMIyiITGp/MefzgyC6fG/tjjrHKz1mFKogHbY6VO2GZG2n0N5spHCnMjaUFCKbOaG6f42uHtUc8a/M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dsl0oNc7; arc=fail smtp.client-ip=40.93.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sl01iZ4md0Sh/owaKhr43oM4UOgymtETL0AfjXLFIs6kGqKLXVruRWwQiVlF6LWYyyH1pSiaQKnDLVTBAqBKqFEBzon66md4OzNqMmKaQqbk110lHH8pTnBp7ljbK6BM6nOBVeE16CUuRgc0hhnia/9mo8yS6rXOq1+hMIDjiUZfr++yYlD8ahYFAAGfPueMq3tjSlUoz5VASggE64GeoJVoVlYykAF6paz7/Wxm1ZVwI56yf1cBKHbtXd9fyYfDP3Ls6rfGYDaofYhM09vd+h+m91Trm1pEP89ybnAeX2jrweUHegeJCsbhHOh7DNE0RiAlYrOXPEpDzuFZWbihXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOOa0Z92dEhFw6UvZgRQk//EcFQFJpg8mZp/mknRAIY=;
 b=AZCjmrJYrNeNck9tDuy9+lyaMIpiLNnq+gn34vbijcg1bu4U2j9QkDCgpXg8yH84tUYvajtOnmOEY5l5sau6JDV23rUGZV5rl6Gw6FWINOxLj8QlFrWotdJQAfN551QjFMou8+WxzqzVVDQE25jaHNB2KGERnf8nO5N+V4kBm3j+n8QTby4DKu3uF74TWcrue2Y2/4G/Du1iffEYo6a0IXFedv1Z9yQIiFbHWdE+fxwHHkOfWSwbwZw+j0NOc4rLDOTrZ6DpuFtuPw4hKnUeQQU5EfYHsZ9PWhLylGPh08H+MS8TwnMRszdRGsXiLGrHo42HMoH+ayZRXUB8HZm/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOOa0Z92dEhFw6UvZgRQk//EcFQFJpg8mZp/mknRAIY=;
 b=Dsl0oNc7yQ90ZB/jOhFKwLEPIMvk140THuV680QUX8j7Mqb7JIm5GnwYErqRTpaq9BkffqqqXqG4jPP0NWioCxG4VZc7lthbF4ozSqusIRssC4OGZkUG3g5Ofn87KTuIeR330J/VFBVzNikY1U/BrYoxG6XaUbSnFkxIT1eaJNw2n32MsjoXDvHlvKmyxHI1lZ+Wc36OipVQTiUyL4xJOBRZil9fhGN+FHE4hlCVtAmuZKT+zLwShtOABJ8jLFM5GeByfhFVGPlokspVHbmM/R2jJVWD8g4anWy8MB+bnt3whqI/bnausH1dV6FexaV3boRpY5fj1+4+rfqNswJC0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.11; Mon, 30 Mar
 2026 02:24:13 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 02:24:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 4/7] pwm: tegra: Parametrize enable register offset
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>
In-Reply-To: <acT_nz0TRM4yXwkb@orome>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
 <20260325-t264-pwm-v2-4-998d885984b3@nvidia.com> <acT_nz0TRM4yXwkb@orome>
Date: Mon, 30 Mar 2026 11:24:09 +0900
Message-Id: <177483744958.916245.860145469758840098.b4-reply@b4>
X-Mailer: b4 0.16-dev-ad80c
X-ClientProxiedBy: TYCP286CA0239.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: a89064ac-80d6-4003-d4d7-08de8e036ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nTZJy5tzR6uU6XGRjDmv+8NbiMgMRAgpizn8jZeSULnUBEsIVhOxlTjHclSByoMryj9c9sU1dG1B8IFgy0CifS3YTAmZ0Ewy5tEXuKbCGeeqiB3yiyuDNvFQQigxqXA1WzrrV/g1b7v0ySJtVQEBi6DrLyfjKiNyidjXT5H6BbuYf8Hn1vSWm1zL9DEw5h4ft44JYLJNAh+3LhXm4bC/iZfEyQDnaO4rUGYG7A60FARrKtQwtvR08IAbdpy1sqtrgxmyoi2GPV0rlkMW26LAMPMADsGv66AjGenxSSq8dnZrohIleLT4TuSqChUEWi/RK6bCIucPd0/UZOAZGhtunO4Yfdvqe3w6czD5/emUi9Qf1tzcklGv/XgF7rgyIcXMH2prlm1K68PRDclK5N2vQtGZYkBvNm1wwrZkN/makk66YqXexGvyl6/LEN2RfAG7ANLUiFw2HZ3NsWn4syVYQtc0mPfuaNfJMQ/YYZ3y9yRdRKLLVx9tx6AWKkhoP6QoKfiHwR7SUKBxYdgkoLkyE7PuP0/fJpviOkE6xCWEni4ifSg4gB7pthgwiC0x3Xo8VbeQPdmyf+uqyUxxSSVT+rgJ8XtHUsY3dx9vY49GDfsNU003ocJbGH6eAmjqRuPH2ev7QgKgAlAXV1cX7U6i1AWr0FkmqZxuzNUQnn/bNOAGOixodvZyk9PjcTMlNM23GLuof/O1W3Fn2Z7HsYUBT68R/at/f5V81kiEHXO1JsQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3c1elMrU3AwOEp4TTRUT09IZEgzaFJJV09BOXRjL2VYS3VUckwrcnVuWEhZ?=
 =?utf-8?B?ZTcvUHFMb0Q1RFBHVlVXLzRZVEhIU2RJQ3BoVko4RCthWG85OWxUNmcwcVdo?=
 =?utf-8?B?bWFtcTJuUDVCM0ZRVUppWVM4TzI5MG96TlpBT2Z3U0l2K05VUHFCMllqWkVR?=
 =?utf-8?B?cWJZZDZmT2RwUmJnMEJlVUZQQTJaSHFjRy9GVUk3ekxFZXRreXQyY21mckJk?=
 =?utf-8?B?Z2JhTEs2M29WTngzUEFXZ3VLcERqaU9MaThxMVIwUDFwL0szVGdlTERWakti?=
 =?utf-8?B?OHlRL0xvY1k1aEhiQW5mTGNJdEFDTzZtbnFlSW1DQkVkdGt4bmdmRFZTQlQ4?=
 =?utf-8?B?NDlkSzdJZkkyMXhvYWdPM3FKSEZkUzZFTmtDUnh5bzZTc3ZKM0hjREVQTXhR?=
 =?utf-8?B?Q2VUdFh0ZHA0bkE3K0xmWU84Nm1JTnloNElvTFpzZkcyQUc1bEV5VFJIYU90?=
 =?utf-8?B?T0Vmam45aEJGT3c0ZGU2SndSYzJ6MnlOd2E0ZjlqN3JYZHZRNVJ1eUVWWmNW?=
 =?utf-8?B?blg2UWtTakpqMmlta1lZaEozbVVFSWNnWDRPbmk2ZGVwUFZEQjZlbHV3VWxt?=
 =?utf-8?B?MXIyWHd6NFR2KzQzK0Z3cTN0RVlnNUsxbDJ2NVNZOE0xUVdBNHdXZWREZWlJ?=
 =?utf-8?B?MkdwL2hIdXVFRWMvSlNMOXRyQStIbDhwZ21ObGxUMVcybVFvSEE5NFZMemc2?=
 =?utf-8?B?ZEdsYStob3JvTTdNUkNOcDdQNlhYUi9hWXFyNXo4V2JobHhpVGxFRWJIUkw3?=
 =?utf-8?B?SWp1VGdzSHM0eHpCRTJsbytZTDBMUTJUS3gxMTdpTHh2Z1phVFA2bWFoNUJp?=
 =?utf-8?B?ZHcvUGFGdHhXamVORHNJTEJUVzg3czFJS1hBVERpZkNTcDdKWWQ1N0MvWVpz?=
 =?utf-8?B?WUVQeUdzaU9XRHp3S0JVemxmTVRnQ2tsT1dSZHA0SVh0WHdzVzBXdHBTdHZ5?=
 =?utf-8?B?ZXZWOTkzWmRHUkFoL0M2blZkc09xVDlqWnEwek5CcmpBZnl6QlZWaFBvMkE3?=
 =?utf-8?B?UklaRm5uV3k4Y09vUEJRYXdJbHJLNUtBZU5TQjZTdVFkVzlQWTZWcWVQYklp?=
 =?utf-8?B?ZlM3L1FseGZMUC96S1h6TEFqV3FMeHc2bnc5NGlKcnZrTG95ODVWY1VkOU9x?=
 =?utf-8?B?cHBTNWZHNk9UbEEySEVGOHE3UWw5Q2NDOTNvZXFBR2VtZmZDZyt4eDZYUzVU?=
 =?utf-8?B?cldiTkZBaVZlZmlMTkoxanFucjQxZzNMUUNuQVowWEJKRFNZNUZaRkRFRG5r?=
 =?utf-8?B?TmlMUDJERUhkaUVONkw1TmkzcFVOYjVtRERpbGNiMkVoaTZNaHFDWDU5a0h4?=
 =?utf-8?B?REcyTlcvUnpWMVRKVklvSytFYkk3S2taRUNQUU43bmdFYU1lN2VLMWxxWG45?=
 =?utf-8?B?ODRjb0taNVhpdGxCb3EwSjF5d0tWSGNNWDVyY1pRaE83d0kxc2tVZ0tDbSs1?=
 =?utf-8?B?eGFoSVdVTERiYUVIWU1odHZheFM4eGFVYmRrYUxDTHI1R2x6NExvZXUySUZw?=
 =?utf-8?B?QSsxUTExMG1oTHRBWlFJa1lTZmdjWHJkSks3SkV3Z0RhYkFWUUtKTm5SSkkv?=
 =?utf-8?B?cnI5YWY2d2FTRjBSVklhaGZYY3VwaWU2UjF3V1ZQc1VoeDdwbGJXeGduQkxy?=
 =?utf-8?B?czhjaTE3a3R4Y3liNGZrL1JaNHZSVXREaGp5d2pwSDBEWURtZFFBRlB3YnRx?=
 =?utf-8?B?dk5aZ0dRall4T0xKaXJYMURlSytsMmVGOElHN05VY0pZQVRIbzNIVUVMMit2?=
 =?utf-8?B?eThZU2RYOVFNeUtUS3dqYkExYTFHd0tDQzBHbXJ3TE8xa0tUMmJucC9WZEkx?=
 =?utf-8?B?aUFlZ1pDRTBOclRQbDliWlN2NXNRSEh5ME45aWF1RFhTV0UyRkl4dSs4TWtZ?=
 =?utf-8?B?akl3d1EzbU1mM0Q2UlZRdHFSanpKTVlxZUNpTkhkcFNMcnZobFYvM24zUWZu?=
 =?utf-8?B?RXo3aFEyWXFpM0pwbUM0QzJrc0Y2NFZlVldiQndTQ2lackhQOVhKY09aZ0l5?=
 =?utf-8?B?UENCbE9wekhBeXJ3NERUbGFRQVVSeGdLcE9lMUFIYUtObCt1eDVtTE1vMEVD?=
 =?utf-8?B?byt6V28xZFhCQWVwZlBjbFN0UStUbGVTdEpzNnRSNEtLNSsrYnNWazd1SkZU?=
 =?utf-8?B?Qml2TnRmUGI5cjRuR2UvYW9QOG5sUW0rbXBlLzAyL0ZYRlpLOFcvQmt0bHhP?=
 =?utf-8?B?NTRYOHhPUWxBTW5OamQ5czhzMXg2djhHTysyQXB2L0M0REdaWGVocHQ4cE9o?=
 =?utf-8?B?VldCV0NvZ3RXdGVBVGdWdGVxOHA3Vm9tcTBMSmJjQVM3UXMxS1VBMHJSczNP?=
 =?utf-8?B?REp4U1cybFozeDVEaW0vZDd0S3ptUWRaRU14ek8xa1hEbXF6MFRWOUNxaUVi?=
 =?utf-8?Q?rW2+FQnqcC3uUZ4MtmkQTeygrHzi1ZfwH7wLFIFnvFCHU?=
X-MS-Exchange-AntiSpam-MessageData-1: QZkmO6H+xFYL7w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89064ac-80d6-4003-d4d7-08de8e036ec7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 02:24:12.9270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZwOxXqdoosJRpsMvzD1bHUbI7OJkEUAbzoFTkEVojYX2Dp5xcpM8vAghJi28h+8wg4ed1yazanS37U9Xppzlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8404-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 2D6F1354C69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-26 10:47 +0100, Thierry Reding wrote:
> On Wed, Mar 25, 2026 at 07:17:02PM +0900, Mikko Perttunen wrote:
> > On Tegra264, the PWM enablement bit is not located at the base address
> > of the PWM controller. Hence, introduce an enablement offset field in
> > the tegra_pwm_soc structure to describe the offset of the register.
> > 
> > Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
> > Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >  drivers/pwm/pwm-tegra.c | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > index cf54f75d92a5..22d709986e8c 100644
> > --- a/drivers/pwm/pwm-tegra.c
> > +++ b/drivers/pwm/pwm-tegra.c
> > @@ -61,6 +61,7 @@
> >  
> >  struct tegra_pwm_soc {
> >  	unsigned int num_channels;
> > +	unsigned int enable_reg;
> >  };
> >  
> >  struct tegra_pwm_chip {
> > @@ -197,8 +198,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> >  		err = pm_runtime_resume_and_get(pwmchip_parent(chip));
> >  		if (err)
> >  			return err;
> > -	} else
> > +	} else if (pc->soc->enable_reg == PWM_CSR_0) {
> >  		val |= PWM_ENABLE;
> > +	}
> 
> This looks incomplete for the Tegra264 case where
> 
> 	pc->soc->enable_reg == PWM_CSR_1
> 
> >  
> >  	pwm_writel(pwm, PWM_CSR_0, val);
> 
> I think we need another write for PWM_CSR_1 here to properly toggle the
> PWM_ENABLE bit on Tegra264.
> 
> Or am I missing something?

This check is here just so we don't change the value of PWM_ENABLE when
writing the CSR_0 register. The function doesn't write to CSR_1 so
nothing needs to be done on Tegra264.

I agree it's not the clearest, but it'll get cleaned up when adding
support for configurable depth, as at that point we will need to write
both registers on Tegra264.

> 
> Thierry




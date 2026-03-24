Return-Path: <linux-pwm+bounces-8352-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI+IIqwkw2l6ogQAu9opvQ
	(envelope-from <linux-pwm+bounces-8352-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 00:56:28 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E271131DD80
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 00:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E305301F33C
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Mar 2026 23:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983933CB2D0;
	Tue, 24 Mar 2026 23:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JZTiHqs3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442FC264617;
	Tue, 24 Mar 2026 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774396510; cv=fail; b=RoqgrBsOCpz+hXtmMaoxSzsYYS7gOC0Uciw47r0lhs5fn3V3RUlI8i83UqbJT0q8inSejThojiYV8Lu573X6676bs1v+wWoQia4VwrdMcsWxAb0MD5wRZ7/wDB6tSp5uefOjgatV1PjTmqIPfwUEh8Kro1a88joPxgTRjZX2mfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774396510; c=relaxed/simple;
	bh=qKH4QPD9q3JmZp1F7NjBmUUZznVtLqMKXwVFGBPUFTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IGVfdg9k9L5G3w97+kvWu3xFHvhcYFDyIO5Zj+ISLxWI+ZG40ucHgQiVlEsbMuvByeWyVw32G9RvUhqxFmI0fsoTo9mVBJazqbLJDIJ2wGX9ZpfCQ07EO5UJxMmPvYJWdx6awUK076hB45+4cYp7j9Ft+kvupBl6gRd4v5n3RFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JZTiHqs3; arc=fail smtp.client-ip=52.101.62.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fkr26Er2BbeIiBnw7lSRUcXkmYYZDrKog2/rQxHSqe5rJsrJ1KXC16/17ffwXCZ24Uhy80oOXxfvkvKcecsdxH7QQuI5FT1iB2JxmeYqI32Nvynpd+1AJJvdmNlG4VFtPyjUSDS62bk16uW/E/A5PXsAp1dWBFrluOcDPhi5Yij4NbYoWY4IPHU7a5+X/FHbBBPaYpUgKcFBrCLfX+beK6vuMa49ST1c2x8tsS7JP7n+wnoTHLwnseF4NJQC6ugdZGoZM3Ri8dzQwHBazNg1eDupIPYIZjKw3ADfLIPKF9ZKP6rjuUFZospYyCIjQHPoHX3VfNAVPCwy3fRYFeK+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EflKZNS1FDZWJIGObSs5QJeRRONZDwdhyUfrq/ltWi4=;
 b=nO32yyPc66zhpA0ifESGUFO4Sz0Q/ik615ZmzScW8671gZI+qPQjHD0iOyoOH6xjXCdiKWS5aAWHWsIT0qCubfAP2IiMOiPn/VgY4rsRgjDHmCL8d8wr2TMic6rvlbgfjlexkrEf4xMAMUS9R82W/PltBFHMRT9sDETfBYy5gDuImlflcVl8V2SwieRmINJS5HJQmRRq0L5opguaODW13z0tzSMypsTQVFplDD+3WU4ACLkx3w3YA+JI318KCgVjf+xVQug1RQjxEGhejwprWBvFzG/xPePzUgDg2corJTweKnnDCQbgIYWKwxchHXMzFOmLhzHW0SffewhjpDk7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EflKZNS1FDZWJIGObSs5QJeRRONZDwdhyUfrq/ltWi4=;
 b=JZTiHqs3qUIBAF7+XwAg5zgYqjA8nb3HX9cuk149tFKxUuJY8HdONMM6qlj8KBB4lqdNWAiHFz10qAPhJhUb5dfqxsdLvKCBxofQMOBBB/4vUswRrvgBX/UreGsjelDccba/WsXyx5bpZFfmCfcUQ6W1ru4Zl9NyKQak3dzApSoE0k5obh8FE2ohwoGB/I9PsnW5k4Xsfa4rqS+XBpkYzs8QGj5B+aiA82OBdZPW34Azp+QwuQQn+wYfSbKkMJQUDwZAWctxjeP2JMjeNr9toLjRyWIDOnbbPgyqhsRPtG6ppa5mifOgZPYF2Vu7SXuJKZSn+qfGkTAwtaykd8wPzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW9PR12MB999208.namprd12.prod.outlook.com (2603:10b6:303:301::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 23:55:07 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 23:55:06 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-pwm@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH 0/5] Tegra264 PWM support
Date: Wed, 25 Mar 2026 08:55:03 +0900
Message-ID: <5526134.GXAFRqVoOG@senjougahara>
In-Reply-To: <acKi4_RPGZnkHFZU@monoceros>
References:
 <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com> <acKi4_RPGZnkHFZU@monoceros>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYWP286CA0033.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW9PR12MB999208:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d0ae7b-d6fb-42a5-cc71-08de8a00c67b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EVfwZHUbHwnP03JXhdQ0jGwB+NlVXUYGQ8at3RQRDJOGNCAyhrUT/S5SANTuVcsiTwaxcEu+FSSJrVdwThbDmwLNaHwXYTrATvBmewqcTzTR5fQYRjSP9ixB+0dPTw09tthzzGViXG4ixHtjJT3m9jQAgBAqwPAzlA8DZ+d+sPNn9w5I2OWNK+W60tN0ShQsMP9XQUKaO4oSz73X2+snUhSDPumkH46ieATIzN/plEQfNHR8e5PLXWhjlAEPkfWJXUiw1XvvTdTHdbNm2uM9MrDy7xMrsIfySytUiZgALkigHDMuakhn4NlTNk5WTEM7p+Kzq0PQTWFV8Pz4CkJbtF13QTdQT8dlmwTBUywPOf37S35FWdEhlNjOlEUm42ctWJ1YkFMja8l+WHlGbNP/YqT4Nl4rmQx+eJPsoFpL2c8yPpCpc0ePvsWCWzZe5n7lbEyqeXUAAFy2Pnr772I1jGBtnUSDDWoHX/GpWr3ObmbWGQF2UUxCdvAmScH2LWs3ffRCoHdSN994ZJEFkMY9c1tiz8nGCjZxRKtiK9ljWZ1O8H4JuADJGbnyJNhqIJrdf8SID/P4FYJR+fjh1TPZyELnKI25JvQERd24LMzS6A3Ux2Ekhis1Ul2FN7joNJgiTxb/n50p5dAMdc2OKoXZgeHV5R8cNSsfKk8RjItj01wWFNVMKS0tkJk9ISCT5bOAAm8085fXyNa1OnrpXDQj5qSFjVNDykyUW4TxrC5aANM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHdzSk90WG54ZUM2eEZBVUwrL0wxaEJjL2JrMEg2clFPdHlBbFRSTnZ3VjhX?=
 =?utf-8?B?aUFKWEdWV3UwSC9XZmp0bTNqMTRFdFFhOFZrcVpHVnFyc3Jlcm5JVmFJRnpX?=
 =?utf-8?B?K1F6RjFFVlh0SUhGL05CdUNXMGl1RU5vMU5hQVc1MXlCQlJoSm80VUZjb0wy?=
 =?utf-8?B?ejN6UnY2VG5JUDRHeTRtbjdNRHd5NVpQV3gzMkNxclBXeUx1YTYzRWxGZSs5?=
 =?utf-8?B?WlhWTGU4Tmc2ZFhMS1ZGS0RaNDhjaWNZVVl4blpJOEZnQS91MTQ5MlRHc25S?=
 =?utf-8?B?LzYwY3VjSGRHMkJwRkgwT0hjdkRJUGJkUVpZSWpHZTZKVjdrL1VGMEQ2MDNJ?=
 =?utf-8?B?Z0FBeWJzaGZLOUlIR0w3dEJZTHBxVnBvN3VCRkhJNU1nakk3bkV0aFAvR2w2?=
 =?utf-8?B?TjhrM0NCalV1Y1pOd1lQSVJwc0FFclpybGRJYkFRdkhaTXA0WnFEZytkTzVM?=
 =?utf-8?B?aVJZeXJmSkJ6VDZXTG1DZjBTTDY1T3FmekxwY1NUWUM0Tm56WHBjTkZ0dHls?=
 =?utf-8?B?a3ZMeDlxVE82SXZOTmJuTGNhdU5VckI1RDI2NllsUWRpR0hDZ3NMM2hiMzdL?=
 =?utf-8?B?VWhxc242UDdFeGRpUUlHbjhiTHduR1N6V2VTZGlPRTcwTTB3dzZMT0kxMUcr?=
 =?utf-8?B?dTRoSUtzTWdoWXF4Qmd6WXlOU2RjL3Z4ZDFSSHh5YXVDSkp0YmdGSDMrNXFC?=
 =?utf-8?B?V1pRVlk1UGZBVWhnbndBaVpPYlNWYVRpbWdHeEVhRVpDOEJ1NjRLUnhiYkU2?=
 =?utf-8?B?RFE4U2dTMU5heDRlZTRTazlTb08wZ2NLNXI0WSs4cGJObVpLbDFMNkQ3WUla?=
 =?utf-8?B?TFpPQTlXbmNiem9TVUR0cWxKeGJiL1ZTSzFmdzJveXhHZHlESVhWWTBwVFox?=
 =?utf-8?B?aFpDVE9SNmVQMlJsbjlEdTdwckZrb3dMOVpFcW8vcTJtVUZ4aUw5eVJQWmQz?=
 =?utf-8?B?Mk5veGF1TEhJbG9TQlkwZ0NJN2VvM0ZwTDlmRFpZZXNTbFVxc0ZNMG4zT1Vm?=
 =?utf-8?B?M0hoNnRtendMYXVvR0x6TkF3TGNkMjdseTFMc2MyUVJQZmRVN1JPb3dTYTEr?=
 =?utf-8?B?TFJheS9PM0RvZExDUUJJMTJXcm1acmVGVlo2TVdEWjNhSXJZM0xpWE9peUJh?=
 =?utf-8?B?SEUvcjBSNndPbXUzczE3ZG5PZnNoeUtBSmNhZjRvanJYdGswLzVLRU1oZjlt?=
 =?utf-8?B?NmxNeVBsWG1ZRE1rNUZJNU9iTXVpQU8rWTJnT0ZnL3FxZFVmRDhQZGc5M3FM?=
 =?utf-8?B?bDBYTWY3c0pOL1VqNHBLUmRaMnlQTDB1QklVSEozbDFyNDMySmg3a1F3Tktr?=
 =?utf-8?B?NGlhRHl4V1ZkTGJnOXJxVE9mSWd6MVk2WmpWeWV2a3ZpZnBlMGNsU1dMZWMz?=
 =?utf-8?B?U2M1Tm04eWhTd3NaTG1nUUg0ZUxGOU5CRUxBZU1WdFdLMXNkNStkQXZzdDlJ?=
 =?utf-8?B?SW9LWnZScUNHcld5V1ZYbVlxVkJHS3ArU2dHU09LOHpHT2o3ZE42ZXRVZFJC?=
 =?utf-8?B?QUJ4dnNGRy9ZUjhpeWo0UUgyYWFMaUlFblFlTU1hWmNvQUdFN3doMTNIUS9r?=
 =?utf-8?B?dkR1MS9LdGV3eEdGVHFWMitMUUQ0UyttaTVFbHVWeUlHV0UrVGRlZUVPanJM?=
 =?utf-8?B?c09LOXJWRitEWU5UYUhEc3d2Y0JrNTBQOEJDdlp4MFFNbnhWUWNaRVltWnJm?=
 =?utf-8?B?R1puV3UySXVSUVo3NWxONFVlUlZLc28xZDI4VXl4QXAyc2FXK2dNbndEc1JO?=
 =?utf-8?B?ZE1xbHNuamRQdFd2ckR4OUd3ZFpRVlB4VmpyMjJHK0lULzRIMk1QbnBJMUR2?=
 =?utf-8?B?YnZha1U5ejg2c1ROYzhPRWNhYm9ka0tYWnlESzk5eTVjaEpjZDNaSDd5Rkdn?=
 =?utf-8?B?NzE3MDJVTmh1VjlQYlMwWFFqYm0zMGNOeHpRRlFiaEpOdEQwcFpPNDZoSVRG?=
 =?utf-8?B?SnhjSzRmSHZhR1JEaENDTC9YUW0wTVI5UVl3N0xoT1ZsRVo2L1duU1pGRUI4?=
 =?utf-8?B?STJ3MUpDSXpLemVEeTZ5N25Dd21EWHAwMEVPem5rREJuaGNDWmdwV0VsNDlz?=
 =?utf-8?B?THJYR2lpOW5xY1BNdVZ6R2lpc0llREVXVElzODBqdTNNOW1teWd3OTEzZFY4?=
 =?utf-8?B?c1U3bzgxTXZZSm9SdC9YbEJ6Q3pUWlY4QUlOWVRlM1FhUWlYTVFudy84TWxS?=
 =?utf-8?B?R2JLTFVCZHlzMytQdCt0VlhYc2thR3Y0S05oVmtYR2xJalNOM1p0cXA1TlJ4?=
 =?utf-8?B?UlVYSlRDUUUzNEJ5OGhycFpBeTltcXYyWHlMY2pSNVF0L09rUVhwcCtmdnpR?=
 =?utf-8?B?TjVyRGVxcGNMdlVKRW9SZzhPUzlTM3V2VUcrRGg1SW11OXVUOTA4d25LYlU4?=
 =?utf-8?Q?TdVjGNmu/Q15vbtemR5r/3A7+LEMBapuUHiSnoyE7RGXC?=
X-MS-Exchange-AntiSpam-MessageData-1: Tz5EVYkcAmq35A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d0ae7b-d6fb-42a5-cc71-08de8a00c67b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 23:55:06.9034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tU/phGO7JGlX1DP4MVeMfsvVeSY5YmikO6ew1YxyZmxUnll0DrzuPI1Wfa2NaxMihp3nVk/10Zoj8lMSyPsCeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999208
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8352-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E271131DD80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wednesday, March 25, 2026 1:45=E2=80=AFAM Uwe Kleine-K=C3=B6nig wrote:
> Hello Mikko,
>=20
> On Mon, Mar 23, 2026 at 11:36:36AM +0900, Mikko Perttunen wrote:
> > this adds support for the PWM controller on Tegra264. The controller
> > is similar to previous generations, but the register fields are
> > widened, the depth is made configurable, and the enable bit moves
> > to a different spot.
>=20
> looking at the driver it would be great if you could provide a
> get_state() callback (or even convert to the waveform callbacks) and
> fix:
>=20
> 	static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device=20
*pwm,
> 				    int duty_ns, int period_ns)
> 	{
> 		...
> 	}
>=20
> 	static int tegra_pwm_apply(struct pwm_chip *chip, struct pwm_device=20
*pwm,
> 				   const struct pwm_state *state)
> 	{
> 		...
> 		err =3D tegra_pwm_config(chip, pwm, state->duty_cycle, state-
>period);
> 		...
> 	}
>=20
> where state->duty_cycle and state->period are u64 and thus big values
> are not passed correctly to tegra_pwm_config().
>=20
> The former helps a lot for testing the driver, and the latter for fixing
> the fallout that you then will probably notice :-)

I agree, there are certainly some improvements to be done here. I was plann=
ing=20
to do some refactoring as part of the followup (adding support for the=20
configurable depth value), so if you're OK with it I'll fix those then. For=
=20
now this basic support is needed to make it possible to keep the board with=
=20
its fan/jet engine in the same room.. :)

FWIW, I'm also considering adding some KUnit tests for the duty/scale/depth=
=20
configuration. Please let me know if you have any thoughts on that.

Thank you
Mikko

>=20
> Best regards
> Uwe






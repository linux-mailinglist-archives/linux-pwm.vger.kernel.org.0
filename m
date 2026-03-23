Return-Path: <linux-pwm+bounces-8336-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE+tHGynwGm6JgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8336-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 03:37:32 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C432EBF09
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 03:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36606301BC20
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 02:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16482257452;
	Mon, 23 Mar 2026 02:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oH6tbawE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67D722B8AB;
	Mon, 23 Mar 2026 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774233435; cv=fail; b=kUYlCljCd2ZmlD2QDSNWcl4InatsC0HHG33ih8y0uYYoCdd5lGDPusAkMRh2hwJmlpATpRuKfXC5oLQ+AIR9Oo1GjKoL3OFL51CM9nbgWLKCQZYZCJ3Eyj7G/J32trJFJx54aKO1JL8P9OjhouKGR4e98IEwtKNz6yfhRPuVF1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774233435; c=relaxed/simple;
	bh=gwfZQNWBWxoyNzQ8CFlQALVbozDu4ay9nAB824R2taA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=U3ic7FVZ1pV1kJ50CYArOTTGACYj5LqJ+K9cTbE+89ajk+o21essDLhyc2sYDVYyMtiLrofQQdQcepoEICMHsCvtIoGTYHzeiqKx6CEtnvKD6FczM8Ebg19NELIaPoxFP3S/st0/aQ8hVXkojmHArIAE8I2GppmMgTtiH29UyI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oH6tbawE; arc=fail smtp.client-ip=52.101.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UP2aIIbDvY2HFfVI51cjjTuClm6ptO8EE4iNS8xpnuzWyq/XEdy46ld3WKibmwviHn7HmSuy5hZoWg1NBjfwIeFlC8/UMoaA+MHR065v0ApfE+4m3tb9jFwRthFp10aRLnSjnqFgcdh5Oo6P3wPsQTAs7cYRi+Nlsoj293kc/P+oon7QIB0kcylNNLVnFn9BeW+QgTLpD+9tPQzvDbWs9H+IZXSZbX8KV4YsRUxwNR+8gUZQn82fLIlrBewiDVuAsV0aiWYuvz52B4AbQNAMNCIIwzo+06NVe9wh86RNhSaLaDV483Rm7SwqF51BGD3yfsaHbdXrQnbQAWq8RpNVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQExniY/fbSpmugBiJjHKjENNl0DOkT3zT8DJ+f5VP0=;
 b=FjPNp0HVYgDx0zamRqxdkbmdaDkZgKaBd7EaDFuRJO8JJzfkpNyC4VgkPn5teBVrBnlXh1zc/A57rxNsD8YX437IJsaHXfdtB+J7KK3rCvN1fPu68dESXhyEcYjwMp3SyGHjOdlzjr+86ohpRF+ZG8TQVHMdiMSvlPTvAO3InBgAj1Pt2D92j9GPwklljlWiPr5p32IwLvRJakl9JkakY+R7X834u8vXH8I6DFg5UfuuaydH2yG3E4YCw2hiVR0NBu3+0n1BvFjXA7rIuo/lh7VRW/fGuFhoBUvb9i/wMyYgrFzsu/AcvgvLur6Q+sx0XsEUMcqaxMvhsB2HIB/RCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQExniY/fbSpmugBiJjHKjENNl0DOkT3zT8DJ+f5VP0=;
 b=oH6tbawERJLxbzhwteOkKDEHT/7ezlnS3cZE7d1CjQxWUN1mX6WwMl2t74qXK4g5loWK0t91wySvRIjSZcZVZFMqb2NlGkgmIeJSe6w0ynehMY7zZV/axkkS+fKnc3Cuvs08OPg4LDPpVomvydJFVJ8XYlinlXmIQwWfr6fzKaCNFoe4MLe6azpp3pcrKR/frTxMJ/c7mHh7c3iOdcLsnFc1LyqP5STq2TwjxIf6QYe9q6C7cW74zIPNAAhXB6YyFPIHbeLDYzGSm4cAltM3uM4H8R86div0wZdgS8xIMTz5gmtwDNKUXikWL9tmOnZRuJg0u0LGiwpva+H39UZ3nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Mon, 23 Mar 2026 02:37:10 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 02:37:10 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 23 Mar 2026 11:36:37 +0900
Subject: [PATCH 1/5] pwm: tegra: Avoid hard-coded max clock frequency
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-t264-pwm-v1-1-4c4ff743050f@nvidia.com>
References: <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
In-Reply-To: <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TPYP295CA0039.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 43088d7e-e634-48c6-6607-08de88851585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	i6NkVvJzjO+7IoR0s7yYWIqY07dExa7Il3Z+o07eg7cL05l9oLp+lJomkGjU5ARgftE/4PSWjviX+lZK1+673lBmAF0VGOOKInnavqlTkDJ5jT9xbJ9vw6/L7z9qGVRxT1Zf/ICalJuFcgQL0ahutkk1ce1pbpZ9KJ3z+qWLPyPcXEDpifP49VPeVfyaSSp8j2W/4OBqUyaIvBYulDZ+Ec+s//H0Omas/LPws/9Q0PoJNDaLXKfU0pYctQ0m+zH0nRyeJxiTqL8VhkEteqJ/4CVm7EGwBcjDDF5TakhpUnfE2mttooJum5b0h6c3vA4eWeRJHv7Fa3vLqJ6ZFfwasyOGP/D8wCS4W+a2fdyzd41j17zLV7OLfJKJkUgvmuj39AEVb39Mi9TcxXn17pLnJGqNSuRadrOUaQcoJ6+HgKMkWPu9Biuw+2/Y6pm009nhz2x4ZgAvjnczAIcZuqujuTif7a+vjiBR7/2xsfFTDTiDVoaeF2vRcB7LofpN1+5iUCvnObmtZhL5vJgfrHi+8UdGUtnoKGuOaJnDm1U8l0VNAwwAqgSE616pm+PVaIDOhoEfmzmkwtP70/b4BHN6SEk9ZpT3xMzjYZa3hST8v2R9qLRKTQn9a4TbwUHglAVoEso+fg5P/jV+j/iZ5C9DMLqGp6tmwBHN0EkN9TBgOwpzmR7jIuvqGfJR9o4A5r8TXm+MjIVsCjTrSDj5+4KCrOJryr/gwN8YBVsT9MKp7y8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1VYeXpKOVVaeW81bGNwTWxsYkpDc21ieVlkSDBpNmQ2c2RjR21TODVmYlN3?=
 =?utf-8?B?Y1d5eXhqUUVVcUQ5NzduajdLSTlDQWRHQ3dleUNqMGwwbnZlblRrMm5iOU15?=
 =?utf-8?B?TFE5bGpyc05vNHprU2VucSsxakVPaGZCbEdkQ2ltR3hySjNsL1liVC9zUEwv?=
 =?utf-8?B?L1FqYXJOcnk3TzArTjhhQmVxMDBZVjVGbCtoZE5ycGJDQjV0WHIvUG1JcEtj?=
 =?utf-8?B?UGV5eUZzQVp1TlJPdlc3NCtDajdBaldFWnNIdFIyQW1LeW9BNENkMXBTeStv?=
 =?utf-8?B?NkNPSFU0UkNaU3pYTkV4WExmMnQrS0k1QVU3bGhiQlZvUktFZ1BTOHpuZ1J1?=
 =?utf-8?B?V2FtUFM3WVhGQlo1QUh6dzU2WjNpenJqWllGMkdVVzFnbGxmaWErVkZHZ0VE?=
 =?utf-8?B?V05QSi9UcmFDdUcydWwxZmFxVHFhekdXTldNYm1MNFdNVmRRL3cwaTBYcTQ5?=
 =?utf-8?B?YVNheEd2cis2MzZLK1dPSlU5RTh5WnVZOXNNd1JneTVmbkRIak1IcTdGN20y?=
 =?utf-8?B?bklUMDBEWG1meHJIZktuZ004eVF2bEFZNWw1NUNTby9HaG9LTEVyTzh3QllU?=
 =?utf-8?B?QWpCeXZoVVByblZDMGNxNFNIRTZjdTJic1lMTW84SkxqczQyTXpVS2FxU0hU?=
 =?utf-8?B?MnNhRG50SzRtU0ZnS1F3OTFDTWJiLzFlSDVRNnIxTVNnWGxRVkY0ayszU0FR?=
 =?utf-8?B?bDBKeVB5M2RzeUF6QnpKVHJ1bXZPRnp5Zk1MeU5ySEpmd1JHSFlVbGpwZ2FZ?=
 =?utf-8?B?Tld6S21sQjdKY1YwcTNhRUg4VnBOTGNSZnZWUlVUU1QvTlJUT0srQzcxOHNM?=
 =?utf-8?B?MVpmY0NLNGVvSjUxMEtlS3VYT3hhb0RSc05ZZ2diM1owRXVtaDJLcGNMTjQ4?=
 =?utf-8?B?Mm1DUHJ5SU1tdUltMWJUTGVuUURwN1haem1kYUhrM3o5NVJWTXVibjF3RCtE?=
 =?utf-8?B?VjlqZkxUbVFKSE9NNWNHQmRFbVRha0RVY3ozZzhQK0g1ajZjVEZ4Nit1NFkw?=
 =?utf-8?B?ak1KcklQSGNwa2pPbTZUMkF3NHM2U1ZSSThuTzdnWXF2OWdYOFQrenk4WHhl?=
 =?utf-8?B?bTVteGNyQVF3ZlB1U3RMZHZUcDhtR2szdHZpMHFZZjMvQ01lazR3L0lMVGpM?=
 =?utf-8?B?LzhRaFBuWTBRRGcxbEJSNzdEbTBiUitwVjZPL28zd3BjRG1qWUs2c24weHQw?=
 =?utf-8?B?U2k0MlpmN2s2bStPblcxTGJBOEtTbENqMTJXSmZnUWZvZXZiQmtkTFQ5UjJ5?=
 =?utf-8?B?WW81cnE1OVh1cWhRVkN1T0RmOVBNRDJ5QnJVaUhxeVR1Wm13U0d1TGR5OUpH?=
 =?utf-8?B?ZTAwQUp3VXdpUXcwQ3FLaFl6aFY1djFWdmwvcm1RWnpaM29qWTJSRTQ3RVZ0?=
 =?utf-8?B?S0swS3JuZEdrVXk1TW5vOXI5YkRCeGg1UnhDSzVYblZVOTJkd2MxMG5YU3Fh?=
 =?utf-8?B?YVlVc3ZqYU1ZUlBHbDF4OHZVT1VrbW9NaXhPUCs4ZmlnMzR0RmdKcWJNWnJU?=
 =?utf-8?B?dkZvRHZPMklla2hTZWo3NlI0U0E5VFlRZys3WWdYZVlGclFzUGN0ZWU0NmhE?=
 =?utf-8?B?bjVFRzQyeEI4cTdwNjlta1VadzFaMGJ6RG1FTTJGa0xBa2pPci8rN1NIM1BZ?=
 =?utf-8?B?eFRiQ25DV2duMGt6aUtNUkpFeEVLSE5LdWZzaFg0OE1uZzYyMWRyM3VMKytI?=
 =?utf-8?B?RlhqUEtKSXV2ZGs5YndMSyt1ZkNIblVtWnhOOFQ0YkRPem1obk16N3VRbVVQ?=
 =?utf-8?B?Ny9yNEVSbEhKOVplRVJZL0pVYy9Uakw5TkkrUExPTkNlay9jL0l0cGlpKytq?=
 =?utf-8?B?TjkzRThONEd3dUJ1QXFnZHRnNWhEVlVManE2ZVYzTXlQWWx1WkxkQUp1Q2NL?=
 =?utf-8?B?dnZXblIzV3pidG9iMXppUDhkRVBQaHpOeDlpdnNReGV1cTExNVRPSlVHemMx?=
 =?utf-8?B?dExpMHVrZDZFSStVTkdGbnQ4R3VKeGZCYmlvTFVVVWxTMk1BMlcwckxCTEhC?=
 =?utf-8?B?NnY0SmpWaTROS0UvaHd0dHZYNGpPRmFxRnVnK1Y3WVZVSysrWDhya3NhZ1lm?=
 =?utf-8?B?dHVaaUc4QTgyYXA4S1FHM25jbjYxdEhheHNaWmlXZHc4bGtkbFc0V1djUFkw?=
 =?utf-8?B?dTZoelNsMXhUd3hBOG1xeWVJejBKbVFnSUJrRk43eUFGU0ZMazJ0WCtOcmhO?=
 =?utf-8?B?MnVRRXBaV2hWYmtUZklPdGU1cmpZdS9WZGdtNWw5dnk2cEU0UVg1R3piRm9l?=
 =?utf-8?B?OXAyaWJENHlsaTVOcnZiOTdkazRWMGhHTWlyaVRxUGZ6cm9aMzlvclc2Z2o2?=
 =?utf-8?B?MCtnWFkrSlFXeFVRanprZ0tMazdNTGlyMU43M2ZEYjRkc2VCTStqVUFZamh5?=
 =?utf-8?Q?AEc/2PEPoGqj+s0NUvAZ7lWK2+JZdCF/2rPch51YNl8AB?=
X-MS-Exchange-AntiSpam-MessageData-1: 9jU/iGIOl7xn/Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43088d7e-e634-48c6-6607-08de88851585
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 02:37:10.7005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l+ZyXVTHkDSuSdW8YQheQAxZI/yefvztm7T/mrRf3McJdo8xSopCglyfjxMQk5qwv4yXaabvWrCGeWjcooTGmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8336-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: D3C432EBF09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yi-Wei Wang <yiweiw@nvidia.com>

The clock driving the Tegra PWM IP can be sourced from different parent
clocks. Hence, let dev_pm_opp_set_rate() set the max clock rate based
upon the current parent clock that can be specified via device-tree.

After this, the Tegra194 SoC data becomes redundant, so get rid of it.

Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Co-developed-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 172063b51d44..759b98b97b6e 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -59,9 +59,6 @@
 
 struct tegra_pwm_soc {
 	unsigned int num_channels;
-
-	/* Maximum IP frequency for given SoCs */
-	unsigned long max_frequency;
 };
 
 struct tegra_pwm_chip {
@@ -303,7 +300,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Set maximum frequency of the IP */
-	ret = dev_pm_opp_set_rate(&pdev->dev, pc->soc->max_frequency);
+	ret = dev_pm_opp_set_rate(&pdev->dev, S64_MAX);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
 		goto put_pm;
@@ -318,7 +315,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	/* Set minimum limit of PWM period for the IP */
 	pc->min_period_ns =
-	    (NSEC_PER_SEC / (pc->soc->max_frequency >> PWM_DUTY_WIDTH)) + 1;
+	    (NSEC_PER_SEC / (pc->clk_rate >> PWM_DUTY_WIDTH)) + 1;
 
 	pc->rst = devm_reset_control_get_exclusive(&pdev->dev, "pwm");
 	if (IS_ERR(pc->rst)) {
@@ -397,23 +394,16 @@ static int __maybe_unused tegra_pwm_runtime_resume(struct device *dev)
 
 static const struct tegra_pwm_soc tegra20_pwm_soc = {
 	.num_channels = 4,
-	.max_frequency = 48000000UL,
 };
 
 static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.num_channels = 1,
-	.max_frequency = 102000000UL,
-};
-
-static const struct tegra_pwm_soc tegra194_pwm_soc = {
-	.num_channels = 1,
-	.max_frequency = 408000000UL,
 };
 
 static const struct of_device_id tegra_pwm_of_match[] = {
 	{ .compatible = "nvidia,tegra20-pwm", .data = &tegra20_pwm_soc },
 	{ .compatible = "nvidia,tegra186-pwm", .data = &tegra186_pwm_soc },
-	{ .compatible = "nvidia,tegra194-pwm", .data = &tegra194_pwm_soc },
+	{ .compatible = "nvidia,tegra194-pwm", .data = &tegra186_pwm_soc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);

-- 
2.53.0



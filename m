Return-Path: <linux-pwm+bounces-9030-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NOGCWxRDWqgvwUAu9opvQ
	(envelope-from <linux-pwm+bounces-9030-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 20 May 2026 08:15:08 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F925880CB
	for <lists+linux-pwm@lfdr.de>; Wed, 20 May 2026 08:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A483C3002B52
	for <lists+linux-pwm@lfdr.de>; Wed, 20 May 2026 06:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ABF372ED5;
	Wed, 20 May 2026 06:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ie1rEgCT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010071.outbound.protection.outlook.com [52.101.193.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A918E31A7EA;
	Wed, 20 May 2026 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779257684; cv=fail; b=NsBg5aWNPEQEpJWyqBioxknFA8y3weSf9hWEf2jM44WuEXPiuwkf/7KgjpWL0JEH/zqs+VMbzJE7K3Lrv6Ja/q2ZxqcZuJlohY4/86rL6R5OKtoWg4FDyVLGxv41Oam3ia1lJlgMIffS6jCsNMPYyCXBU2/uEGgs+AEA3s20WoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779257684; c=relaxed/simple;
	bh=D177hHmYQFF0z/LyMIIpkd6AQHMRIrfp8dblVOTwD6g=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=LxaGkHNkVJ6t0hG5IUeP6w95Dn0CuZ1CfT6xwmWfN5MgiSGaBZVoGaIEEN+vsiNXVrGfMWgP9S6A+wiTbDBw58wRNkxf2tUQHMwQeyVwK77nBJz5havaiAayWL+7Xtzmx3FdmTPzb3DamCjwuT3zpnVd2CQ9WJ11ZQj650ylL04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ie1rEgCT; arc=fail smtp.client-ip=52.101.193.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu7FDwj6umNRnBIHwECg0Q5tsPxLJfoXk2DlTtt7KeQQZmoPJr+/h6z41j7lTVfsd56FNNmAZvMyc+ZdpFXzispZ8nOKTIBIr4ePg7RS9Cjt86uNpBUj4N1VAm7VT9OP7xnGg089QUt3DTqexIaE++6fAgfIMM2lqErKKlU2AA9w3qF/obMU1PHxIkoJn6ix6hif4sWMo87WV3D1vk2MMSG9JL4hEV6p2uqwLD47oGyUq/G5EAP2VFWDi60JvWrpEZ2Vcdnbn2YQJbTgQQELFCGFc/UsgesIqvBEDNJiMp98T2RGXQrv0mduCB7YJVVGRsaB7/bwd0EqlWNwWiqjiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D177hHmYQFF0z/LyMIIpkd6AQHMRIrfp8dblVOTwD6g=;
 b=LaYMC5w2qKqZw1sSTGez/ATrphuUkYQX61px5WD/io2aqc0OC96d7aXGt5tmGy7AamIxMrkI3pSgVC5sH1yQ53xA1dmalcT/fEroca1SFdCef7+CcEVQ76DF0JlRb12NP/aSJ7waJNDrW3XC4dGfFqVRJWJ/Dej/T+hYkqExLA3dNRWspFfSrfldePZSVl7VFZ+1ZDpO7dWvLX5mY4PMO/L1x4u84DgYVuxO4Scu3GmZpyTHhpojpzcN/GxPAVvwQ5QRS5dXJlKNuBTGIpRt/qjTe4ugBxyCOdtBTd69Sesy8jjK3vD78XfgApR9ZC6HvNthKHXysAH9hsxJy+Ojvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D177hHmYQFF0z/LyMIIpkd6AQHMRIrfp8dblVOTwD6g=;
 b=ie1rEgCTm15zXVwFb7WBI4tFissq5ba63lJCHfm8TXkSxSnqtxvOguHwuuZtzV84mtjXwhCF5bthX6Z26JyicEZU9fn+W4z60qJl0K3bQRTAJudv55nOx7y8WfGqXd7G2MfptN79/RdA3WALnVIWe04uG2bJT4XDoJufnZ0j0W3uCJA9Z6SgUVZKkG0o4EYv31FrdA/61Q3VzP9Ob2TN2achdKlGjJXRE/9b2p8k5qREoNFbbG0ORZIPB/QRkQrKa2nWJ+zT7ThbsufEWpRI2B7r5+XHmd3ZT30VRFL1yqkrYvgkld6livpCCU8Z/+FmEF6LA+UUzgBs/+uALrVJWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 06:14:39 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Wed, 20 May 2026
 06:14:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 15:14:36 +0900
Message-Id: <DINA7GB0LJB7.1NOZ0MMPCTSPG@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 10/27] rust: pci: make Driver trait
 lifetime-parameterized
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-11-dakr@kernel.org>
 <DIMDU2XL6PKO.RUXA0XPFT94R@nvidia.com>
 <DIML7T3R6BXP.2WSFVG2VY63LP@kernel.org>
 <DIMMO6Q6WKOY.1DKWK8IBAP0W9@garyguo.net>
 <DIMNPI2H382T.2U2OH39B7C2B4@kernel.org>
In-Reply-To: <DIMNPI2H382T.2U2OH39B7C2B4@kernel.org>
X-ClientProxiedBy: DS1PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:8:457::8) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: d38eec8c-b864-48c7-2c99-08deb63712b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|22082099003|56012099003|4143699003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	Vc1Ip6DymfcPF7N2t0YKW62T936J33kH1yAVH8Q69v1jwIAOzYWVlxz7/n8ZKo6tUKrkRqhYlvihF85rWWolbWfs3og7Ov4UpgLFVb9LvaNJDEnED25eTw5uF+uG9I4QqgnTKMlbutJsNV4i3+SGHIC0cbWfeZ9qTcGa3qW2IAPPJvC6mQkNyxZHk2v1LY+L2bXBvoTdkiOy26iTZdi94uNQUzIWm8XTfcJV7Ao6eV19Z23PFzWEFly1ai9ntg/MDt4DbBz77duye/yrlRIQe0MR400EtuUb0NvsMj3iytC36hmYwFkRmYPPf2cjMJutZBtuKRPvl277gQd/3RCdhmSvJS+nhsgwNlaFCXs14hUw0khvJ9V9ooBYXK0K9KTdEnz24ZrwYV1zXpK3wmOEfAmJ16eq7fc+d2VOC5S6sql/Gc/TcM9fnoq2DlIirslIdF7RB/e4XeEZG/1ennVjoCrTxFqbd3aSeuCjJKPu6vmsyzh8sdqUb2WYhV+aYnwEqg5GzTICGscdY01chb+nOmbTbzqREKjDrffltaTRWi4+7rEaY7c74ZFbLXrwJqVfDiPNfOacFJVrS7dgr6D5Co6DjHlViRAfKmeEAORawTpgJ3pwryq5H4t0GVjiVTysu7JFGaAaatSmY/oq5lQKya4OguC4A5AfsOH50Agto++Zyesse718F9Q+PW8pO4B+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(22082099003)(56012099003)(4143699003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlcvTVBlRFAvd3BGNk1rdVkyZTJCVFMxRThVaXg5SVFqZWtPSlVWRTVVQ3Er?=
 =?utf-8?B?NG1zcUR5Yk1oRzl3dHVRV3ZUQjJWZ2Z5bmZVVzRnR3ZIb2R0eEpxbG1pQkJ1?=
 =?utf-8?B?d2t4L1dOMmFrOWttTXo5L0JsK21ua1Q1dVJITzRzcWxLeWFPVHc4aUF0NGtl?=
 =?utf-8?B?WHNrR0NnU3dsVDgyYy9zOGhuLzVyQ2NIN1ZuQTU5ckkrdjJWbmNGeFU4RXZN?=
 =?utf-8?B?MVpOZFpMbjc4QXRYNU15YkJuWk9DSlF5eXVrck9sZkxXaFo1ZTNSSFlPbUJx?=
 =?utf-8?B?VndYdDRaVTkzOVY3ZXRITTEzbG5aelpwZ1BSWDljdWxzV3NjeWFUMUJVb2ts?=
 =?utf-8?B?MU8vYWtsMHZGL1dTblA2WDBDMjZyaFp0dmtWQ3RYR25aVGFYcnFHcUorSVl1?=
 =?utf-8?B?QlQ4cDdIa0RGcmxtQll6anU3WU5oaGFzVExwRGlFS2crS011UzZsYit2N0pr?=
 =?utf-8?B?d1I4WnpwWVhFeUZjUGN4M0ZzaWRUYktYdmgrcUdka0NjRTNvWHUzYmJjN2hx?=
 =?utf-8?B?UUFneGdHb1YzdDVpNTcyeEkwdFJIdFRTY2xQbTlCWWRBMVdNQythMlVUdlNY?=
 =?utf-8?B?OEtnOFNrUEtGU1dTVFFhOUZHM3h0cXg1YW0reTBUQU9rampZSnZvQWxkV3dM?=
 =?utf-8?B?QkNzQWJrbW51bVczUDB1cDhLbDhVbk9uMHYvS3dVMERQN1ovM3kwTThabDhW?=
 =?utf-8?B?UnNaam5scXdGeGZkWk5aUXVObW05d09WQXUrZVNPYzF4SHNoa1luVjlsSkZW?=
 =?utf-8?B?Z3BxK0RMSEc3WGwva3daakxWQkdwN0xRcURDNzh6d2dDOXFXNXZlaTh4eG5E?=
 =?utf-8?B?L3pJZTVJSncxMmo4QjZ0c1N1RmhuN0pieFZJcXpwLzAxNTZYZk9Mb2M2TDQ5?=
 =?utf-8?B?VFlKZGpXdW1NYk1oTmo4VkJ3aEZpclNNVlJZUDBrQVVoMHJMaVlBd0QvQldh?=
 =?utf-8?B?SjhFbVFqZVNvYldVYnNZWUtwU1FuSTE0R0dnRVgvSE5vTEZ6VkV0eUc0NmpW?=
 =?utf-8?B?K1YwT0xqcitIWDU0M1Nxd2VmK3l3UU81aDhRaHhyL0sxMW82Y1RveWVReTBS?=
 =?utf-8?B?bFIzbnptUm9yaFd2MEtQSUNoamN0dzYxbDR5L3FYeXhOWXFnNGthNjZvdmZG?=
 =?utf-8?B?MjlmNDNQTzB2TUxQbndNQWRXT3JpTTMwamE0WkNDSU4wdGtDdlN4VjA4dXVl?=
 =?utf-8?B?ZU5vaEZ5T1ZVR2N2aUZHc2ZjSmNKc2g1dUdTNVlsVUxTbkJDUDNnQjJiOE5V?=
 =?utf-8?B?Qml6S1p4RnlNVG0yVkhwQmpEZVlwZ1loR0NJVFNDc00rUEl5Nnl1ZGxDRERD?=
 =?utf-8?B?bWlaZUtLc3VLYk5sLzNSNm5OTlNJTG9waS8xRkRPNmdPamZocEJIanJMQS82?=
 =?utf-8?B?V01yYThMMFJBRzM5NXZ2Wmk0YStWbHdJd3dnR1JMaDE4aFZQUlV3aHo3MEJk?=
 =?utf-8?B?Q2JUbSsxLzZGQXhTSU1pOVBqKzF6dVZwdFZlQ0FNQkNlRFc2NWx3VGdrSUtl?=
 =?utf-8?B?MDlXY2JwZHhlc2tFbXRyazNiQ0VMNEhWUWd4Q2sybXZpalhBbHZKd3FWNm5S?=
 =?utf-8?B?Z2lUK2RtSDduNkNLYWR5bEhOQmFxNUticXIydEZhT0xoT1ZQMVFCcDEzTUtl?=
 =?utf-8?B?QXUzdUIrZi9hN2czdytRMjltVVlrQit3REhHMW45ajIxNUwwTWpVYnBuSndU?=
 =?utf-8?B?RUNVQUh1MlJQaFRCdVRmVXhmd29QQjVUWjRPZjlKMFVPTm4zc2VZc0JNSGlT?=
 =?utf-8?B?QndWaWRMYnlLeWZtK24vUkVLT0gydjloSXVPTEtGOVF1SEM3YUdkRmRYaGhh?=
 =?utf-8?B?MVE3VjRuSGJOdEt6TFRmWTBGK3NMYXZNbzhLV242VGdmeGxXVmxERmRHT0RP?=
 =?utf-8?B?NTI3R0hoNy91cEJzTlZhVUF6VVdiMHZjTEN3UmFGTXVJZUlNNTVKMmRQZnJl?=
 =?utf-8?B?bmFRcmNRUG5qSFZwWExXSXN4dStGc0ovcm9aYWFRYnlsMkdxZjdsdVhwTXBC?=
 =?utf-8?B?L2lnczNETFo1RlBUVHgvVjlMMGRJRjVmSmFkM3NSb3B1NStUVEIreUZhUGty?=
 =?utf-8?B?K3pzcjYzcmQ1UTAyWWdObUY1RW8vWjE5Vm10QUUzR3JJajhZYnNJd0ZTazNN?=
 =?utf-8?B?VEJHOVBkL0lheXA3bktRNlExeDZ0SVVDTWVSV0JGdFJ2MGpFYzlUTjJpNllu?=
 =?utf-8?B?VXRWVWFsekpNanpUaFZ3bHRKWm5VeWR3MllmcVE1YUR0K0FuTlZxL2FKcWdB?=
 =?utf-8?B?bXRSbkxDTlNpVEJkbHNISHJzVlVrNFYrcnI2N0s2RExad0habkUybVVTUXFW?=
 =?utf-8?B?TTh2NHd0NnhIOGRvR2I4UHMrZ1duWndaT0ZMaVBzd1dyd0tQbFBIVkZqSFpp?=
 =?utf-8?Q?TX3XT8ibzhlgVmm+MRyivKWyMCN7fGLngW0DwcLjw7aLP?=
X-MS-Exchange-AntiSpam-MessageData-1: ILWrC3vj9ror5A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d38eec8c-b864-48c7-2c99-08deb63712b2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 06:14:38.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfaSh4p0wzl76JnPkl40WBYRV145lp+clBID797QrOI8NFZcEU1LWXgg34bBUIXx7u7sn7e8dMnjJacT0Og8BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9030-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecourtney@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 87F925880CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 19, 2026 at 9:36 PM JST, Danilo Krummrich wrote:
> On Tue May 19, 2026 at 1:48 PM CEST, Gary Guo wrote:
>> the callback should have `Pin<&Self::Data<'bound>>` instead (the outer
>> lifetime should be callback-scoped)`. Did you forget to make the change?
>
> Yes, I thought I had that staged already, but forgot about it; good catch=
,
> thanks!

I think this resolves my concern and it's nicer for drivers to use than
requiring covariance on their `Data` types. Thanks!


Return-Path: <linux-pwm+bounces-9108-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP4uGF8sFGraKQcAu9opvQ
	(envelope-from <linux-pwm+bounces-9108-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 13:02:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3765C98D9
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 13:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6DF73006B7B
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 11:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0C93563C7;
	Mon, 25 May 2026 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SDlBQuOL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013053.outbound.protection.outlook.com [40.107.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7637324B22;
	Mon, 25 May 2026 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779706972; cv=fail; b=BOiVrALUboJ32QkIodIYTsonk6BvkguPqq616Tp/CPfExxAnoe/aKfvOcPzPNkhzkEEqXv0YJUZ8J5lV+yzio/xR3FYtbCCAZyicfMuKiaUoiW8HuuR7tCSirT4XmOtUuXreojQwzzdn60LXcJ4qMNRS37zHTI8pNrYMIGHd31s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779706972; c=relaxed/simple;
	bh=5FpnROGl/wonNT+7wE3uMMKj1abHQP2iVM8oBFaptbg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=fSh2fUyOOIEZ/R3TpRqR8ja4+m70lxQyetnBe0A+wmBCadUYBXqBSTuEN2CVJ0Z+HTFD0e9Qgmd5Kri+OPDXB1F0mweH7ywKBsiK6b/NfbEKGgwVvSGdBeFw+83jgYuw91q/9/KMfxeu4B1k00cDN4NbyQE0UZgok8uzzj6U7/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SDlBQuOL; arc=fail smtp.client-ip=40.107.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXoZ1jmktu12gzsqjV3V8BJVazEDKQFhfFBS8Sj2KlffT0qSKZww0yY0Smr/sxGxbcQBI8i40R3moUsY0Jd8DyehOmIF8B5cDGRsFvm0Scfwc+EynQIJfuvGWcZIO6fuk//gqXsbtyrrE+OW9DYXCHkXERh9E1fa/zPvGOdD72jl1EQ8OJcpdnVQOq+9eUTOsWk7Ik+rRJtPbEJgHyG2V+0d4e/1XE9zo8vPIgXfiK01BcVcbDsaS1lf4s91KbCEbxlOveQkDHvl7eE0oWWeZuB3uAk9Ys8QjNH6q5AhCt4DLFMTESRPTED+0d6nD37n4C7hYygkTuHyP1fvLtvjkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FpnROGl/wonNT+7wE3uMMKj1abHQP2iVM8oBFaptbg=;
 b=PZk49TUphBqzwFSvWqPfwO8doUiS0RBvDJgWW8IGnSsYlPRhrnjRnxJgjyPDr94hoQQv7o/TL7jxI9+/QKW3bqpPdHkIpQ2eQkm3jlQJVvboVog1JNRkpF/tcBVy4LVEYbARcKaSr3rPS9IBAn/mLAtIsM8jx+ol+hmXYvgaJ6p89THgyo8bo2RCUe8YX1lEwfMKuyQEZNfx7zZ2NveXSwdZ6rwG0dgJn6XubmQGFNsguX/0z3+zwrrpQpiqGg8mc9p8YY8R5ZYH6qcj13nL/pd4VKtsm6NNP1AxHgzjWYvomXqShGLwCB6+8NPZbcY511DaxYekVBQoLy68lMcfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FpnROGl/wonNT+7wE3uMMKj1abHQP2iVM8oBFaptbg=;
 b=SDlBQuOLOj9wJxq+gP1YC1untSDlpTOmfeW7l8va9LCUuQbCdIwmIEQJwOUxpPjX6q0x+/hI0+NglzO6Kj1hMXqfvDUSBAVpfsr1YfpluWnNh6S/qSh2e+v/qrABbxDm8f5hbbU7hOXVXPKQW0Ctl+yHQy3HOa1mtdzK3hJdAzxqgTEGnL4dXy2DXkNH6GVqxsM0VqhHC9ifQyYcmwoTJCZw7ojkE0Zvtf/kxA92+YxOGRIPCaw0EkSBUJcW3Agv7GS3tL4anxoNxLmFngSTz8Gj84pweeCROgBtoAk+tpiU5RrmkiY8EbeDgCu/XkJbSnZO6a2fqLc1rP7gE+WD6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8179.namprd12.prod.outlook.com (2603:10b6:510:2b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 11:02:45 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 11:02:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 20:02:41 +0900
Message-Id: <DIRPGQZO0YYN.1HZX96PCQ90MT@nvidia.com>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v4 10/27] rust: device: make Core and CoreInternal
 lifetime-parameterized
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-11-dakr@kernel.org>
In-Reply-To: <20260521233501.1191842-11-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0200.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6a3baf-7f33-43e1-5eae-08deba4d2608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|10070799003|11063799006|4143699003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MvEzrsXj8PvyQFSlomI5h11SeH3fEOSx2EpEOly48GetUvvfK3k5prWru9dfP79BURuobajmKTh0Vhx3ujirvbu+voU6yYYqtGRH9+ytyE2KDM5HaJYenEmSkhk8BOYCTmEi5HEyCbI/UlEY5dgzcR+B3nJhuH8Q39roN9LfKld3QrP3YF9CGfOlTD9+/OFwOvZEpMu0RSS+LOd8ObeZK5Lvstk758qq6iuw3q7Tlyhq8YZm1uRzJpCmk3NrbF59dQT9vaOfJTk+A78yDbSXeT5Ha1o9nwZISArYnwekdhVLurFO+N719g+B4fidaOshPyyO9hELoqVX+jlR/5gju57f6gf68AsBScCZCm0R60ZJtIEh/P+cVI+1C6mYvYc1VS/eMNDhz7ZutikHq0pRGz10k1WJm+WXF3jvPxz6Nai9+O+umOyhUnNex6ox/L9tbQ/aHwcNQ9diM7fMimK04MQwXlce4Z9/X2sBTZV9Jzr5yR6E9KBMQxIsSHDn9aSRwkPY0/6Xed8/gIGyvLLKcvyPz3embqqsw0N5/FTUWU8dDzei+ztg+AXvtlOG9kUfvGhdW978iEkc8D0jymucXZ7MWGTSGzbyVUKldTv+V+gH7NTEjJw4YtzJzxu5SuaTTOaubx+41FZw/rqgI73XDbf+7B9RpFytuED+4gWc/InHwMp7sIyOA5ml4XYXCiYN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(11063799006)(4143699003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L05uTXJYM2RDdVRRdGZRTEcyY0RabXlFMC82bnNjM05SdENWTWtiMFlWUFIy?=
 =?utf-8?B?V2dremkxK3RoSm8wV0d3Q0dRTURKVHZNSWg5UzNlRmRhMlJwWS9OTkFmOVdq?=
 =?utf-8?B?b3Rpb0VLdm1vTmJkekFDa3A4Zk1DWVY1bWFzZnhlU2JDV0NQcjE1UHU5TjVv?=
 =?utf-8?B?OTVUQTVQNkh0REZEVjJmY05VSCt6YzNEWWp0TCtUMTEycGVWQ0xIV3NVeS9K?=
 =?utf-8?B?ZDArMzhteGcxZU9YN252cmR0R0JNNERTT3FuenhiNFZ5TFdFNStPc1o2S0NO?=
 =?utf-8?B?d1YzZzkyVnRVK0wyTVdxeTdKYVJreVpjQ3VhZWFacDlSaVNXaSsxV2tyelBL?=
 =?utf-8?B?UThSZEtYbWlpWEdkT2Z5MlJYS3pEOHRYSW5rQWhKMFdsd3kydFpzSXc4UE4x?=
 =?utf-8?B?Y25hMmVkY0lWY3g5Szg3c0NhNnZDWkpNalp6bzBOUGNtRitYZFlwYnQwK0ly?=
 =?utf-8?B?RGlDYVUzazl2UkVObDdtNG5ibjJLdWRtVDYyNXNqMnFicTI0cGtwaE1oWW15?=
 =?utf-8?B?MUo0a2hCNzRiUUM5ZHkvYysyM0FTeldha1RJdC9FRHMyZjR2eHNjZHpVRjhu?=
 =?utf-8?B?aHNRclZ5NURkL1MxckVEVGpRZHBuN3FVbVlnODZiUDJ2L09aZHVKaFFlcFFG?=
 =?utf-8?B?Y0hUNEZDaTV2QWJ3KzBhdWM5MERpeUVsckRabWVZTXQvbFVlMy9jbU8zVHox?=
 =?utf-8?B?cXlwNVJTSkk1QUlOTFRVVkUxYkZLUWhCTFZJWFpKN2p6Z1FFZVVyNnU0eVl2?=
 =?utf-8?B?MGtJcmU2VkJ6VWY3UmV0UEw4aUpWSU82S0lHMnpnTWIyWlNsbFloeTZ5Nmtz?=
 =?utf-8?B?Q0VFWVlvZXh5WHlEdmkrTURVTlNyUk16WHFxUTJmLzRTUmlkYjRzTW9ndDdD?=
 =?utf-8?B?SUIrQzR1MGl1OERtMzFtMER2K1ZQbFZ6aWpKa05FYjE5aERSbFNFRWYrMHM3?=
 =?utf-8?B?S3l4NzRpRVFGMlhoeGc1MEx1alBrUGpvdHVjWk1pL21rdGVVR1NVTC9Ldk95?=
 =?utf-8?B?QVFyTmUzZHgzZkZhQlhaRkhHMlBNaVp3Z0JiWTIzblBtbkx6VWpsaFhvRnZ4?=
 =?utf-8?B?N1lhYTZkenpockRKS29MK1F2UndGWmpLcHFTT1RJUEZXVEpqT2N2WDFTdkJq?=
 =?utf-8?B?bzBNNHFFdytMUmEyVkZjQjA2OCttMXllcFpyNmlmY3NRYVZ1TGVyTkhqeFc3?=
 =?utf-8?B?VVBCbUljUG1MWU9BVWJrYTc5dTRXR0NKbW5pcno0RGM1b0c4bHRmOE9TbUVI?=
 =?utf-8?B?YitoNkRtUVRWODhibFFVZStmMmdSL2plK1dSM2tzaUF2ekVHeTk0YitvbXpj?=
 =?utf-8?B?YmxOdllJQy9wQXM1djNxSEFtVjlXUjVva2RJYUdHbHJlNk5VRlREdkp1R3Bm?=
 =?utf-8?B?UEw0OVRkc0Zxc2Jwb09ZWVhPLzRqamZ6QUZtVXVEeGpqWUVRZUhHQUdzeTVI?=
 =?utf-8?B?c21rVEtRVHdBajdIZ3NOUHBZSUNtTUlyZ3VZWVRPMEJzQWpNblJnQWtqanZD?=
 =?utf-8?B?RERxQmoxT3g0Qy9KTTMzSEtKNHc3SDFYYWVFaEgxUDg5UTI2YllDUFgrMTkv?=
 =?utf-8?B?MUxLdk1WQ3NmQ21EUGtMMm5qMnBQYm11bFhhWnp6eVc4K2JlMFBJMGZoZXZy?=
 =?utf-8?B?NU56OEpVNjZQSUpWd0RXNnNjUE5hVFJQdnc1c3ZZVVFEbTJ3VXMvWHhVcGhR?=
 =?utf-8?B?SGhqREZiYnZmeVMxa0t5SG1YWUEvNHg1VHlTWTVvcjVRQzUyTEZmK05vblUr?=
 =?utf-8?B?OTE4bHFCUHB3bk94dHVSUm5vTFUxVXh2bytCWDlSWFp0NjM2U1hlYk5FWG9j?=
 =?utf-8?B?TU1xZHZhOHFuSUI0YVF6VE5sK1dTWnlzMU9Oa1MwNjVLRlgyK1RkV294TjF5?=
 =?utf-8?B?U000ZStxc2lsa053ckozbEUyajIwMDB0dTRrUTROQ1hVUGxEK0VWL1ZpOC9N?=
 =?utf-8?B?amI5QlE2anNENnNCTHdldzY4MzNJZDBpbWYrWjJqL3JaSm5SVG00bzJ4UEhZ?=
 =?utf-8?B?L09WeCtQRy93TTlwV0kwRGJscHhZOFJjMXNuTFpSWWdROGxYYmVVNEtSLy80?=
 =?utf-8?B?Ym0xZ3pWS1hNNXRJbTNyU3dCMDRiZFoxNWNjbGtUTEtIL2VWOGh0dnFCTlBk?=
 =?utf-8?B?TlJCK2dmQTFrTWQ4U2MyMjNkZklpK0NNb3lxTitPMlJocUp1aDk5d3JudG5V?=
 =?utf-8?B?NktkRHUvRlU1Wlg5bmJKN215WDltNldkS0o3NWg0SkJLKzE5bm5WU3JNRFp2?=
 =?utf-8?B?Z3VzQVkrREJXVHphZ0t5eXc3aG5Ra04vZWVsWkpBN3k4bFoyRUtLTTB2QzZj?=
 =?utf-8?B?RmprWVdXWWZSY3VwOW9tRHVqQ3BsNUl4MXRBYXQrNW1Fd1JQT2Y2YjJCYncr?=
 =?utf-8?Q?Tc9dX/uEaVyOLlclMkrLAHcoefyTVXqEDNFT3LGw0kkLH?=
X-MS-Exchange-AntiSpam-MessageData-1: EVKfAt9zohLBsw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6a3baf-7f33-43e1-5eae-08deba4d2608
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:02:44.8645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqFD5gTsIiVlM1D0epPx4YeYJDZAb4o6/eI/bCgs3BeZH8QgZr/MJ5E57wQ9aH48oqobb+Ysfg5Sib6la6Z+xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8179
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9108-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AE3765C98D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri May 22, 2026 at 8:34 AM JST, Danilo Krummrich wrote:
> Device<Core> references in probe callbacks are scoped to the callback,
> not the full binding duration. Add a lifetime parameter to Core and
> CoreInternal to accurately represent this in the type system.
>
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>


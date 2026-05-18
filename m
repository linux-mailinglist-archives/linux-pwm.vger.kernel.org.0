Return-Path: <linux-pwm+bounces-8957-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB4nD+InC2pAEAUAu9opvQ
	(envelope-from <linux-pwm+bounces-8957-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 16:53:22 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEDB56F473
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 16:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC008304B8AE
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 14:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C583FE34D;
	Mon, 18 May 2026 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KM0BWXWb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010034.outbound.protection.outlook.com [52.101.193.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F93F5BE6;
	Mon, 18 May 2026 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115397; cv=fail; b=VShRr3xFXsw9XkMeMOGB2dw0iwbEDFfRajfBd+X1Eitze5Bu5QuFiSToeeXloXiuLq7W7PpxT6LdUM/U8il0O7OmNu3q7PRX2GKslW3wQshazOB7wD9J7sqP3k53xGhGgy5Q0cVlkP5ocLwuD0LU1xaZxIv63Z4KDYiAD/Chfg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115397; c=relaxed/simple;
	bh=fjkL8wHr1CVEbWUCMtU2ViaGgqC4D9iKKL/rGhTFiNM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=GgeZgo8s3b2WLsSfPMuWyOOLb2M6USylW4IQWS6mvpvomMSvJirenHbgH7qwSzn/EmrO4dLNo61pTrWkZ/ppSfAPOhVilXy/YBEO6onUTMUBvAE2n+Sj+Iw/NjFzYWlDF7sFNZcfowB7eQStw6f6apd48uiyC3Npm5dHmdM5vFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KM0BWXWb; arc=fail smtp.client-ip=52.101.193.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bh7etdxA+Ybvs3/8VTtp6ttcL7uwht0mZD5ejCs1ZSyCseOZT68t0aH08FObzW9BufPguLP4ljLt+leSj9z5SvuVSh5nroYkaWUIHl4zgH2pOpweQrfQdtTAYuRRELvhnS5tucBhvrJhlmi60oNQXnYIevEi0yja2yvK+0LFdR1KNSXwJbwxOBRjhBPMNz4xh+QVgS+D+W5FSOL85Gkj1xRn7RltjtWxfOrNrZQ7EncZ9GLZBBy71OKQs/QRw6yq1hYgLeBVeorcrMFNZUFvwiYqUUcQaSU2w6RtI9+Ixnn1Sq895jp/7cYa03CXW7ftRlSBo/Ya74X/CojY9uG6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjkL8wHr1CVEbWUCMtU2ViaGgqC4D9iKKL/rGhTFiNM=;
 b=JITMELu7czEH06EfkNcOFN5Iug2sfMrK3NAbWYVY0tq5IV9mWHehfHmuUqyIyFYIMySx9eRdGEVwN7fPRKv8ZwAIMj430QV3IKpLmv2d1mDi1fhchQqPHypK/nmKWOk5BlbQVLStfPGrdDr37cJUuVy/S7v9G/rzuYRhy2stRej5VIOEcZX0C8KhyL2xGJ1SGEbj47Nvdxj10hxzmEMSfL0EAlvmYbq+xerRzrlUPNtzAkIChviVAsaDYx4Al1PcxrhrUFxHP1Ou7nsXl3WIu0i1Bm2yCMWdWQeLyC9L27HlesSpwnYb6vvPdK0EqUPGWVLIDZDLYZI6eUhyiagiEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjkL8wHr1CVEbWUCMtU2ViaGgqC4D9iKKL/rGhTFiNM=;
 b=KM0BWXWbZVRoYLlvFtFxHb035athZNTAOXmnB6zmKuPaytjrPLC44SL6wnEbS/EXC4Ddrov1GkVP+h/aI881sACoQWLjhY5ax7p+haASl/KHcH3rrynm6ttwPw/M0XQrIfayCuHZ0alNMO7p4frkBBGWEx/YDr1KCCdP4brDcEYnitSTLHXdhmSUl3osM7XtiTFmSwjzGuXIBzT0tbaV2f3+M8syTHdVPibmbzL7zyeYGgbN19N+qRB0MsQub7FJ9gkq7iuq4moCsP1slV1baD7jluHSzroTgg+UacYDiMdqrAW2DdlgjFQiDCuo+n+L6PO6TkWecTvC6x35qxBvhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 14:43:11 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:43:11 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 23:43:08 +0900
Message-Id: <DILVRQC9HKY4.3VUMBRC44W9RJ@nvidia.com>
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
Subject: Re: [PATCH v3 03/27] rust: driver: decouple driver private data
 from driver type
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-4-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-4-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0300.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 9808e5f8-05b9-47f1-fb18-08deb4ebc8f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|22082099003|56012099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	wXQ+hk4tDdVVK2avq1hNUO85EUwy+mAAiYrWAXQbQljznyNV0X7qZvJB5oIytSh/Qn8x92f+zxZHw16mo6A7y4ytOZjBufbRTw2Q63W5gVVJTjFpmX0uCkThmBu2c3Xecjv2BB++whGmotzbOifrHhel4G+fbV9dr7bCrJcEKn7VuSn9SKytC8TtUT0t+EzhTEQeNYeRkiJ6rfY59VILJhV6nCIdj4+qfys2jE6zABh2JjLr3hZPB32eJi03vkx1xnCtoEFrMo92rBjQchOgcgQFbmHqKHCJXetF7b5Dg8xZg03H+6yO2J87IV63Da3wV2/4JVwoyK5BsJz6ZQZhLhkGxWwzbSQU/ULZsY6LcFcj7MpvJtymNGx/DJocM9hi8dsbxe8/MqVNpnM3foZIXbHNHrMlMAEaMBelHvYF8sdWkeg55cu7COFyR3/kn7HJjJ7n/6nCAQ2O2N4l+Z3eD9VJOW0jKFSM00bhSOCgix8cwe/qYg/991qowuohypTttkwqqGwr/wKYgeHAzm0aPrjC7mCbGJrve3rfe7BQOpsWVZBYFm8kea9IoaNaNlCM2xNl6joxxkzdkiLkkgtNcTajCwe6jhtau5VN1j6vLoTf1l8V7Ex5M420S7bBxWD9exE3tc8ouuOuVRVPE+Fn2IypSCHhUhzqDPJgAdUAiyymrpfelzAVabf6dyZMoOKu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(22082099003)(56012099003)(18002099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3FsTVQxcUhVbDFIRWxieTFtTnhFQ01tZE5vblhkenYzdGRBYUIwd2U4a0hM?=
 =?utf-8?B?aHBoQUdXcW9veXorM05HNVZmZEhSRHkxRlRtZWFaVEU4Q2dRc3VsN1pxM09q?=
 =?utf-8?B?Ung4ODkxTDNEK0ZJemJOVXVXVUQ1SUtFMlAwZmg0ZkhMaWhXemM3aGd2ZG5X?=
 =?utf-8?B?QlhZNjRFcVZxYlVzeVh6aHNzbjBkSWZ6MjhxTlYzcURIcnRCQUZlRFN1NFM5?=
 =?utf-8?B?TXllYnhyYnEyQzlUelhwNkJYTE9ab1RQcDU3WlBoYWJ0Rk1NQWQyQ2E5YTdy?=
 =?utf-8?B?cisrRituYUlJZXFYa1laemVVVEUrMzE2V1hrRURYRUNQN1d3cDczNkd2dlVq?=
 =?utf-8?B?Ky9hbnh6YktzZjd4SlV2N01yQ3dWMktMUEszUlErU1F3R3l2Q2JxZUhnTHVH?=
 =?utf-8?B?L1dmdCs5RlVKeFhhZjkyb0ZKV0pUUTJraTFOYW5rVFliNUVmSE1jWXpEc1lC?=
 =?utf-8?B?QnBVMWpkY3BZdnBRdDQzOEErUEorMDhrZ2pVT2gycUwxYzcwUE42NjFNUms3?=
 =?utf-8?B?dUdSOFVWQ2pkaU02RnVDd1lLa3FRVXl6V2J4V2hGamFMRTZzWFMyU3owZk9j?=
 =?utf-8?B?OWI1ZlVGdkk4Y1RpbTlxdzdJTzlxeVJLaXlPVTlIUFp2Y2tuMmcrQ1ZnODJY?=
 =?utf-8?B?Z2xxWHdnWGdtbHpvYm5XUzhKUjc0US9vQWVHaTZoS0s0cjBjQnlTZzVkV2hx?=
 =?utf-8?B?Rm9jOHZjYld1SytOSkpYRGtLUE10Tmx1QTRPRFhjS28yNkV0RkpCY09VNU1S?=
 =?utf-8?B?dlZZMVFVMm1kOXFrdmF2SjFwcjF5NGVOeHUwVjhnazdsTXRxM253V3J1YVhn?=
 =?utf-8?B?cmpaUWJhMVlrMGwvelRuK2dJZUhqTnh5WXlkcysrZ3ROdFR4ZFdsVEFsb0Rk?=
 =?utf-8?B?MVV5OW9pcGM3VDI0aTBXNzN0aGVtenM3ME91MVBCV3hMYUR4K1duUHdIc1ZP?=
 =?utf-8?B?bHN5MUpXNjREMllucjVhb2RaUElnNzc3TFRsRnBnM2VnNE0rdGp6bTE1RmZF?=
 =?utf-8?B?bzZCNkp1ZUY0dHRhZU5lLzRBaFJ6bFFDQ3lzMVdpemoxcFkvbGM4Skp3alFY?=
 =?utf-8?B?UW9LVU1ONEs5b20rQmkzUkZmdWQ5aThEdW05cHk5VEJSbUk0MHVEbWNEdnhq?=
 =?utf-8?B?TlA4RS8yMHU1blRhOUVTajJXZlVaQ3QxZ3YwM0taK3ZUend3U3YzZ1Rma0hm?=
 =?utf-8?B?bEtteDJERUtCZVBrRHBEeVF0THlWdGthdCt4ZEZ5WCtsOGlxWTdxU1BybEVw?=
 =?utf-8?B?UC96YURodW92SlJsRy9PakxnRHlkbXc1L1JJMWpFTDlBd1kxWnhSZW9ZZ2No?=
 =?utf-8?B?NmJJRlVaQXNITjBvSEZZYkxIOC8xVTNjcmZqRWJUbkFZM2VHVmZWcHV4Z05J?=
 =?utf-8?B?MWN0c2ZLMXJEOGpEdXlGTnpkR2RYak1jaGtxVzVqU0tyRTNOMW41OFZWcEdX?=
 =?utf-8?B?MSs0MTF1YnE3cThTZ3RxZnpZT1RWZGl2VlhTNWpIbEMvQjk1YmtXU1lGdG8z?=
 =?utf-8?B?SjJTY1AvcnVMM3hCenJBajNRdGJwTHdFOXkxVVJLV2VLZmFrRDlrM0VxU0Qw?=
 =?utf-8?B?MDUyUGRWbHpIY0djeWg3MmljZys1RDJwWlV2TGEvYTk4bERON3RTKzMwNEVt?=
 =?utf-8?B?ekVoWjFucHRHRXlXeWY1WW90QVJLOUtZbldMTjloclJYV09nejRjQm95dXlD?=
 =?utf-8?B?cTZkVTg4NExraFd5UHdVZWhVakJEdFFHZ3Ftc1BTdFQyWDROWmgrMWFXNjEr?=
 =?utf-8?B?UE44L01YSUpyS3p6cTAvcGJROThLVkJ4QlhBSlZaOUt5NTE3aytmOHJQcS9v?=
 =?utf-8?B?bGRPQmZ5ZXlOWXYyeTU0VVlDR3FJcWNrempuSUk2NzZLczR4cS9TWGI4Z1Q5?=
 =?utf-8?B?UnpKQjkraE11Sko3RnlacmluemVaakpaRURYajJ3Vk10U2lnUngrZU1WQ2Ey?=
 =?utf-8?B?c29hTEY4NTg3MWU3ZlZSWjZDaTRWV1JpTnNQZWtkUDFTd2xOVmxsNkc0R24r?=
 =?utf-8?B?VmVOWExqTHZaTUdyem8yeWRVdnJvaEpiNTYyM3FhSDNORGNmWWsyVTRzNTU1?=
 =?utf-8?B?OThWNGc4bjVkRWZ2NWduN2gzbjdZVnlvRHBuSjFsckg4UTVuVENpOW43QzdH?=
 =?utf-8?B?d2VBZU1HRVpwemtMQk9KR1ZYdjJmdFJxK1pCUzc1VmJnSk1YZ0hPcnczUVIx?=
 =?utf-8?B?WjBCWjdWTlNub0R6UFcwWTEzSWJ5TFM1RXl6eWpDODNacTZHaVc2WUp5TTlG?=
 =?utf-8?B?K0Z1TndBdHZnRmxyT2UxcWljL2twRThIN0lyZDFRb0o1djlqYnZyRXJYVjlZ?=
 =?utf-8?B?U2xDVnFnZ0d6UUovckh2UFlQT293bnJ5cVY4aXBnbmNET2ZhcUUxb3Fha2Ns?=
 =?utf-8?Q?u7c8THje2DVJxvDRMl/zRTgfdJjzsT0ulD/Z29WgIO3Vm?=
X-MS-Exchange-AntiSpam-MessageData-1: fYWa3tZsvucHHw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9808e5f8-05b9-47f1-fb18-08deb4ebc8f6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:43:11.7962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlsW7kPRkxgptu7mPnL2nSidJnjozB8DlWI1MHHPqRHaqB56HJI7rqGQdncfzaF5nrvsbEUahhYbuUInHocthA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-8957-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: ABEDB56F473
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:00 AM JST, Danilo Krummrich wrote:
> Add a type Data<'bound> associated type to all bus driver traits,
> decoupling the driver's bus device private data type from the driver
> struct itself.
>
> In the context of adding a 'bound lifetime, making this an associated
> type has the advantage that it allows us to avoid a driver trait global
> lifetime and it avoids the need for ForLt for bus device private data;
> both of which make the subsequent implementation by buses much simpler.
>
> All existing drivers and doc examples set type Data =3D Self to preserve
> the current behavior.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>


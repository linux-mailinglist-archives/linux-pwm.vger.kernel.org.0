Return-Path: <linux-pwm+bounces-8963-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sElBBqsqC2pAEAUAu9opvQ
	(envelope-from <linux-pwm+bounces-8963-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:05:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 764FD56F867
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 17:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7073A30C64AA
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 14:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4186526E165;
	Mon, 18 May 2026 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F+pMcCDq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013066.outbound.protection.outlook.com [40.93.201.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0048A262D0B;
	Mon, 18 May 2026 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115694; cv=fail; b=e9dwxWCDZAQQPzzElRkZ+zZpYcVis3y0tBIK7U4tczI8LtgiARJ0VG2K/JPldDbxSJP5AlfhOmU5Fn03E8CaTWyLvwaImgG4vj7ZhLgNQ6lJZaemOAlD3yBhT7KCaiV5X+D6z9aUKlMymZCl3rE0cmV87F1O9mPLjdIk71X4yec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115694; c=relaxed/simple;
	bh=kKeEusefyZ607PWY7DuVVQVQrEh96muyqXXwC5BIyQs=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=k1NAVIVtqXOaMpcMRiYGwktubcoqV5j78FDBz3uBJ5Y5NjzQiLZp9yif+hO0m4gy2xNc8eaPwykO/zATFI2ktL+IHKUcVd9Tw2QxRIxK6O4FZjZ4wc4sBGncjW9ctgbvfrFndgRyDMY/UpUT2DXJa0p8HHMxN/5zBfRTpERVX1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F+pMcCDq; arc=fail smtp.client-ip=40.93.201.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJfWByVE7GO2s5TCwseCu7HgYY4yaOACSFlmxu8IsB1pUtekzMlb2L9FFkwPA+QEqeLek46ybMAR5Rtk29QdVNzKcozFUx5Eu4WKsyequaq2VsYD8x9Ru4leJCqvIfp8QKWnWXTGZXi6sWotfshGJL2xklJHdoGHBJeglJNAanx6NhRKfyCPRZNS8jbbfIjGvBlB87XMjQgI1m/4dXcuCTavlXLvUB1i6C/lSkVt6NGsf0ecVnnQ9Slp+2HI+bJJclTuJsAZl0BB2VYkmmtjwCLWbh2nQLrpJrpKqVrRyq88n9TvmcWLfsvi9CYIYFjGTxj75pGoa994lYfGZV0RKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKeEusefyZ607PWY7DuVVQVQrEh96muyqXXwC5BIyQs=;
 b=f9HZ7b39m/DuKyq9raO95Ao+y3yrbZElJe6VlPUYMG53rXDHMyHrIs5VnImuuoQ5hECg++nNMklVRfKthikMVVpZYQWHPPrLJhLMDz8X3twl6JoriJk861SAWAoClkYrrAr874O2KYVghOnpkbkOYXehMm3ysmh4S3cXTrR/0h5T8cRdPIaDWEdg5p4JnHCTxH/pKyBRYAyCBEqOKkYruqxp1rrpBrW37mlHQAFL55nOMcsJz9fLrrBPmpWSZDE8qRLwShImjYi0NLKKLyImqaS7EcNg+kyuHNUL1Pwr4FSOJgDXws7rji4pLM0YtH353erhzu0Uu9voZt5QMqjmEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKeEusefyZ607PWY7DuVVQVQrEh96muyqXXwC5BIyQs=;
 b=F+pMcCDqYbMl+XKhok4KOZiIngjsDhCIt0mBVJCWQlsR5YvCGoyUGWMiLWWmy5kji4hkjcBoDfEXWcCbcxlRMR9aFBuQ/Zo5eOR8hZcFXFlNdHzBfhOeM4iJa52hdpe54hDLGHdli4p5nhDQIhobPt/nEd4DgB3ZFvY1Ocx0ubws5Xk0cGPacZAyReKv4ZVbr78FR3hZEA4CUTZJhE/WPMzzr0OfPklicBkYuPVg5JImE239LOLvIhvEdLXfrsQFLdfkoXm2xeYX02xTw1EUqttIWNOcdIufIch9ruLBhWCHqfXYWRMeA9zn5cY+DNkqUpO4lxN0KVAZvZ9NZAh1tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 14:48:06 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:48:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 23:48:03 +0900
Message-Id: <DILVVHPYXIPO.3NTWJ5XNTXJG4@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
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
Subject: Re: [PATCH v3 09/27] rust: device: implement Sync for Device<Bound>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-10-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-10-dakr@kernel.org>
X-ClientProxiedBy: TY4P286CA0127.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 17aab9b1-dd62-42e5-dbb3-08deb4ec78a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|18002099003|22082099003|56012099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	/gZAwIkm7JP9i+MA6K3/TYmv6m6INiMSeKU9SZjFasZEi5zlxJova0RdPdQuuATwDuvnvNLjg6rjHooCseAUqtxyo2jaYpQDbOMFiUU7ouGcUWJgwsR6OceXSIeXMh4Q7idt6sQDYhF0Hj40brv76sObiAWxNpqynpHsBdhtzuOC9s9s58F4Jsn0KioYnZuKORXk0iaganlmXkDs938VSWCgid1T3s9Yun7GHFBrjw2fm0RY5Eo0e9QAmzEOjCntChAYOrAE4kDtxTTc7mnAuoU4L6mo0+YXeiSMgO10iIHrVQDKXAHQirsaEKQpcXJHdTdkuScKNHe04MpI+CCwuheO0YV6Y8UDYL02kEyx7D5KSqoNSr2gaBeafekFisSHl3UDzq0TejpgM+r1mO5HpJHBFiL0LP0USlxdt++gC+5Qz7IaUKqXadgPWa6TkY+EBvmR2LSQyweT1E8yuA26exwfE6FYLoaDJ4O/N+8REmQp1q+XlxEnWF5XC/V/KdOFPAjQ/8AsaT0j/oPmi1PuWh/ZF7KTitYZ4Uf55q3VeiA6kLis3iFdcRx4cJuBFI2xcI/VsNzXE+buxqqCierHgXr7R5WKB+vBR2jtB21+jtRLIPmo7QjRbLXpIJDTef6hbnRYIy8F6Ls1swBm7h435u7A8TNzfiTjOXvYgpBA68LROwM2wuMjxqkp7+NrR0iX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(18002099003)(22082099003)(56012099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE8yVC9WTXRlOVk5RFlIa1c3RGM2dXdjVVN6SEhDUXllLzh0VHBtZDNLdjhT?=
 =?utf-8?B?SERFKzkybTQxakdxTkRWUWJlTm1qOGlCM044Si9HVFNiWVIzN0dBaUtPSisz?=
 =?utf-8?B?cWs0aGdKUGRaZHdRb3lRRHdjWTRZWW1Ec0ZXNWpNZkxKSUxLR3Z5S0R6Nzlq?=
 =?utf-8?B?eFdaYkplM0dWOFJsSFpZcWUyMWliODZ1ZDJBRVpkN1RpMisvWnJNRk5UdXBR?=
 =?utf-8?B?TnMzaU15dXlVa1M4TkZCSndvWVYyWWwxa1RRaUM0WCtJK2pFUEZhRDAvNi9I?=
 =?utf-8?B?WUI1SmNDUmo3SE0zcVBNRmptNXlhaGVFM1ZqdDYreW8xUFZnOHg5TDNROEJq?=
 =?utf-8?B?UFh1eHJyYUtsUGN3UXRIaUV6UTFYcmw3K3ZuQStMdEJCMENaMit2UzN4anJs?=
 =?utf-8?B?ZVFwYjFaamxTTmNCL2lVK0o5R1lKaWZybTFWZTl1Rk1HbUpjYk1ZU2hiMllx?=
 =?utf-8?B?Zy9zNnhUeFJNK1ZGZmNnT2RJSEl1RFY0bmpzdXFEbTB1QVVUVDlPWEViWk9i?=
 =?utf-8?B?YWxudVdYM05rbGRLK1JDdHhHclYwT3RJbFFZYVlSUDRETDBLdDdvMEpoeEpt?=
 =?utf-8?B?MlU0dHptY1AveEs0MkoybzdvOG9TNCtiMEhEZDlFMCtZOERhbWx2eU4rREpt?=
 =?utf-8?B?UXdIN05ueTYxQ0pidTlva2RicVZuQmxhVEp1OG9GWk9LcUc5RVk0dFlZMFZt?=
 =?utf-8?B?eG9ZMWt0STZhMlVTeEVGZkF2RC9OT2paOUVQQ1hzcWFFN05vcGRpZzRlQThR?=
 =?utf-8?B?MFo3cW1GLzZXOTVCejByZUYrU0p5UUk1Q0lVM3dwMEN3dndqRWlFd0dJMHRi?=
 =?utf-8?B?RmVFbDMzOHdPZEF2Uk1XVWtTR0g0WEVQVlIzYmNhZENDR3pPbHY4cEpnVXNp?=
 =?utf-8?B?MDFVTGN5bHZJRTBUZ1JNVUFpZWxNR1R5TUZpMzBEMGtvZTdEcFBuSitWUmZw?=
 =?utf-8?B?Q21KSVcxYXJCRFE3UXZ0Rkl3Yk0vL1RpNlVMMlRhcll4b01QaWlBL05PMTVk?=
 =?utf-8?B?bjlva3U3N1dhVXlzWFpEZTRMbmJTOCthYlFRcU1jcTNOWm16Z0lxMEVrbity?=
 =?utf-8?B?NXhBUTJNM1NOSWV1REp1ek1hRHRIemhvckJiNU9iVHlUSlZHZ1pzUWNrUzgz?=
 =?utf-8?B?NjFZOFJ1N3VFTEl1ODBROWdBWjRUTkI4dldzWE8xQ04ybjlDTGRwN2xZZ0tJ?=
 =?utf-8?B?dWJuN2NuYXFiL2J3NnhSSi9nWlBtZGF5L1IrRGRtdEFEUkQvdDVlUDNUSmpJ?=
 =?utf-8?B?R2FFRkNnZVRIWGlPc01Hd2hsOFI2WjN0dlRaN0lGVHM1SHd1NGU1d2M4TVl6?=
 =?utf-8?B?K0dCdGZpelBMa0VtYnkrOGNBS1NEMzR5WlVNclVrMWRHdi9YNUc2YkhLNlhQ?=
 =?utf-8?B?Um5lMEpVVDFUc3F3eDgzcGJRYTlXalQ0eUtMV3dXaE4vMjhNM3hLSkxPVHlM?=
 =?utf-8?B?Wm16SUFVN0w0SHg2WkdYRDFqa2p1L2ZvenlvdDhJUTcxeTlZM0NhdFVBb1R2?=
 =?utf-8?B?L1Uwbk5WRWVNdzV5UFhoVW1LbE8vYSt6a3hpTHo3U25LYkpQaUVSU0kwelkx?=
 =?utf-8?B?TEhCMHZEWVMrWFJ4TTZjb1FOSnozYVNzRzJPZXdPZ20xd2NGQTUxdlFQWWpq?=
 =?utf-8?B?ay9vTlUrWkF3cDgrcFdVbUU1cUhqdWFFT1ZReEZlUnRxY0xEU0dGZ1lveE9m?=
 =?utf-8?B?UWp4ZEYyUENDdWQ0L3cvaHlYNHFNc0t6a2t1cGExdzhSOE0ramwxTS9WNHNQ?=
 =?utf-8?B?a290SUF4MU41NFZVWnFxT0NScWdnMXRaSklucjZrc3Iva1dMVXJ4MlJUYUd3?=
 =?utf-8?B?dmxuUkhoWGtqYXptUTJtb2pnTUdIWXVVK3RrTXFDcC9UUVVCTjFEMTBiWTRV?=
 =?utf-8?B?Q21RWGFZNVUyYXRrTHFuS1dEVE9Fc2xxTWFSRVNqYzBEMklOVjN5TlIxL1p3?=
 =?utf-8?B?ZHZyOEllV3dpLytVaHJvNFRGZGJnSXhBckJCeG9wMDlTaWI4TmEwYVVqRmpD?=
 =?utf-8?B?OHZpTStrdHoxeCtBNUlGRThscU02eGNZNmNyMEQyWW5WdmVaL2srQm1XSjRu?=
 =?utf-8?B?aVRmLzJKbG8xZFFpK1FrT0R3T09vTFZQSndlVUZoNG8remRwSUZEdDBUSFRU?=
 =?utf-8?B?SG5Hd2tyRVZONFByVmtvdTlDZ1JZeGh3eE55YXJ0dEJxRldGNzRiakU3UHVB?=
 =?utf-8?B?bzlVR1lnTjRwNStWWmo4bkJ0NXd4SmtkeURsUnFTVjdNNE13R2liZmdmU2dO?=
 =?utf-8?B?dnNhWlI5RS9qZmwxOC9LY1BXcm5wN0IxTElXMnpmU21GaTBkRDJuU0N1UWZM?=
 =?utf-8?B?Y3cwR2JCK05XTm5KaTc2b0dSZFJ2YWJaM2Ryb3FqZUt4OUR2Q25SQ0RNbGFo?=
 =?utf-8?Q?WjJcDJLfnS7JxYW3Z5xmHRx2N7w1gh4TB8Y2bczkMN5v/?=
X-MS-Exchange-AntiSpam-MessageData-1: cjep56vcaM55gA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17aab9b1-dd62-42e5-dbb3-08deb4ec78a3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:48:06.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8m9NHQeP8Of0V7+bnAlYSaGdU0xrQMr85u/ZAgOzJo8WX2Fb775DGjXwyfgTxR+vhq5Ohjbq5QC3Yu73RtpZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-8963-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 764FD56F867
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:00 AM JST, Danilo Krummrich wrote:
> Implement Sync for Device<Bound> in addition to Device<Normal>.
>
> Device<Bound> uses the same underlying struct device as Device<Normal>;
> Bound is a zero-sized type-state marker that does not affect thread
> safety.
>
> This is needed for types that hold &'bound Device<Bound>, such as
> io::mem::IoMem, to be Send.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>


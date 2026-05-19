Return-Path: <linux-pwm+bounces-9001-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NPGGp9NDGrjdQUAu9opvQ
	(envelope-from <linux-pwm+bounces-9001-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:46:39 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C23F57DF24
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3408631C9030
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 11:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345A44921B2;
	Tue, 19 May 2026 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="z5Xi8g7I"
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022127.outbound.protection.outlook.com [52.101.96.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4670397E81;
	Tue, 19 May 2026 11:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779189622; cv=fail; b=GvrRGxsZ1t78EfeaDc/+gLEmn7fMSpzwSg3Rf1Anj1y9tKx586nmn67ZHi2BAGaLJb4iOoMBM1cZY4hKpUdMa1svtV6sa0Oj9pxmSkiiri/67OE3TZ9+MkE/fI/mkP6yP0+u9MQrdXvggXbrhD6Gg807DUtHRkLBSG1+c7yvHvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779189622; c=relaxed/simple;
	bh=fxPMee/SGVaiWmNzeai7MUqcogkpCcnitnX0HQY1AKA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=gdv5IBJa8bDrLKH0wpfhDvX132xUEGSQdBnuonnHzEAiUvtvcGS4ow5Wg78ISKfAo66ePYBwtIgKWMepCq0kSGt6/VGQAI8KxZP034oRtg4vJCFFf//OP08GWm/P7acwt6dCuESS6EKc1/faB743ijhpaVj/WwCC9Xh7eP/mRNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=z5Xi8g7I; arc=fail smtp.client-ip=52.101.96.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e//CzmeX/xPBmKf6gK7lvEt4cQ/BmuSS1fwgsI3qs1WuN7SNVfiQ5ara0Kvo+xd4RZ5TzpQH44a9Kxpf4kUtLEhOs5NV9GJHX0Pa7z8ILntdhgoAQqWOqZYdXpSuFiOLrIwN7a+v7+PnYlcbqkQaq167/+lyDLX3sOd4pUATWa69ZcNGVzDSgvFLlw9oiTS+RkKuduxEW6ShjdqV98JjbjDPY+E5FrcOkW6ZnRdnbOt9PYHRw/dw0U2RX69sss7pPnLlpj26pekXgITE1hw940KlLUrvxoz1QWI3cLhDRhwvdZuLEPzqGWHHVwkHrrS5CRtvwiEqWD47SPtyilX9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxPMee/SGVaiWmNzeai7MUqcogkpCcnitnX0HQY1AKA=;
 b=iBGOAU0ccAJZP4f/VdDFaBMPxmYXxDSu0tZsGrXHSHWx/zFuX9jigaCj3kMs6xOXX2uT1YWCrVmPNY0+TSyvkn82TsUlfk84iXoo9cOXzqrVjWkzrygVcvJd8zVmKqZDBFxE60gOfd6y+ugipeMWUavEHg9uPht6jVx+w4AjLyHVglkUEPLaralU7LX60QMAzAXt01zelZVD/S8ps1TnhzxI0jqp5ZwASDVop+U6MSLeIs306og/zZnuvccY4G8GCAwR546w+akR2XF4j2rdW9mOkd5JoBl+fQBEkfPD790A5hxLDCCgGzLFTP/PLiyY33zdlrPA2fZhTSadnRkL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxPMee/SGVaiWmNzeai7MUqcogkpCcnitnX0HQY1AKA=;
 b=z5Xi8g7Iaav7LH/txM9UwNP8gXEjcA4PH86tPNEaIP4LFiNNMDewiA7CXRJXgojHB8pJEh5zastmcTciyfIMQmFMfvSOoOwPeMr5NeFKNCtCusbV/+GnMbnTA+QrV3WPrsHFPGLKLcbaGosVLW1ce36dyzDmtWa/DFIhzym39r0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB7271.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:368::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 11:20:15 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 11:20:15 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 12:20:15 +0100
Message-Id: <DIMM2XJHLR16.1K52AYHT02CM@garyguo.net>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <acourbot@nvidia.com>, <aliceryhl@google.com>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <viresh.kumar@linaro.org>,
 <m.wilczynski@samsung.com>, <ukleinek@kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <markus.probst@posteo.de>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <igor.korotin@linux.dev>, <daniel.almeida@collabora.com>,
 <pcolberg@redhat.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pm@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 17/27] rust: auxiliary: generalize Registration over
 ForLt
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-18-dakr@kernel.org>
 <DIMHR3ZPEL92.2HVZ0FGPM54MF@nvidia.com>
 <DIML7JNOV84D.1CK4G9MBZQJ3T@kernel.org>
In-Reply-To: <DIML7JNOV84D.1CK4G9MBZQJ3T@kernel.org>
X-ClientProxiedBy: LO4P302CA0038.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f176137-c7dc-49d1-489b-08deb59899fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|10070799003|366016|56012099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	roniEgcIEIIZBnJdis8kHkUeQepU9Uv3EjYGnOEk8nDpwjgTiMpDpDQseILRgPqTXjZF/Q+bQ12oyUwd0BVlmpErbJN7ePJRjrSSWaRFdBHOgXh9WtClnPl64VIDqSwq+byb9b7JEsyx3SvFxTfEg1VzjoCOc9f0O1Jw1muZZBmXzvKUwJCO3+k2RfSGqyA6nInzdp5hZqFC9vc/dHt0p7m2EnUNHNIhnLIp2yYvSQmUOf5L1Vk383ofiJavL/fnuELudNe87mEDGG5QbeX03upt7XLTtZ84q8FRCspW5B7dH4hr1+pwz6DMtsXzWR2jK2xLVjLbLRxIkpH64+fMJx9Fu5oXlIgOldNnL6ItHOOSk1/ZH6N7TdoCdKgDpCha5q5HYs6MKN+viHavn8EPRonTLo2pgIBuD17G5Ek87lQqX63/SWvgWP+CBqHI4j0xWwtUEig1wnCGNjjx42lVN8ykdm35e9CqUnPFmJkDFQ9aDN/JaF0GwqvfvHUeB7ZsarP2KcEtaL+wX1M/UFv5tBkac/3feIh01Y0P62V6GExUOHHzLhMHh+mSXVyU9fzY9+XQvcdSAbBv8RATSNqbjNeTlIR+M9GPhPQvy7J70mBfvFoZ3JhOtjecm51v57u5gW2NwVb98yXVEPZEodGMZb3Zfa2KuP7WS26Aho7P4EUEDqiImUVD6Cb6Km6evhzI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(56012099003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azVOL3pseFBJclJZRG5OR2duZFhNdGQ3ZzJQZWl2bEk5dXp1eDh4QTI5RURv?=
 =?utf-8?B?ZWxDZExRRnd4QzJ2VEZvdGFuTE1OYmRmNWRncWFBVzZGank2RElERzVVanV5?=
 =?utf-8?B?VHhWNUpUMzVsMlJDcmpkSm84a3hnU3NoTW5ZdFRhazg4Y2dMTnJ4SFlYQkpM?=
 =?utf-8?B?UkdHbjBUYmNONThSblhGZzZ1UXhwd0Q0eUUzdTE4Y3gvbC9rbWVBL0ttVm9v?=
 =?utf-8?B?aXFBOXJVVitlY2dJR1BHMW82OTZxWFh5a01nM1o0b0hUMzNxTEJvREo1MU9o?=
 =?utf-8?B?YmRITk4zNFMzZi9wYlB5dFdYUk1DUUQ1a2lDVVloNnFabkRUY3Y0Vy9GS3Vy?=
 =?utf-8?B?UWNzUmRTYlpxbWMvdkRjeS9La1ZqRjBQWHZtTHpzQ2JCQ2Y0eUJWQTFoVUNU?=
 =?utf-8?B?L1YyZU9tSmxhYnRQREE4MjN0dDVFVDkvanFJTWdUM2hOY0h1WmNNMjNEN1Rl?=
 =?utf-8?B?bDVxWVZ5UDBvTEIwSW9JQWZTZ29vSGZqOW0wbGZFYmpjamd3NjJMMDdDbndx?=
 =?utf-8?B?NHdPTGp0UHczMEd5ZEJMR1RaS09aVHBNd1M1SjN4MmVObGw5U1BibjQwRUtB?=
 =?utf-8?B?TStNQUNyNWpDOWZDKzArdVdXUTV6bHlzQXNPOE5JRFBiMVRHYWVEZ0pxWnhS?=
 =?utf-8?B?SjVWMlRUR0pzVkJMRFJMblJIa2tWMGMzYUprSHdDMnJGSHNVK3grYnY5dlVT?=
 =?utf-8?B?Q0pHOG4wejUvOGZQektWVkFsRDNFeGxRYTFiM1hSUEZZYk5MSElUWktMQnFl?=
 =?utf-8?B?alB0OGk1cTJFQnNiWW11c1dzS3ByTXNHcTR3c2o0dDJ3RU1qblNVZHVBOWpD?=
 =?utf-8?B?bGlDZ0d2T1pMaVR3SGh4cTNtQVRRMnFVQjBWcHQ3aU5HdStYTGt3NTl3NUhZ?=
 =?utf-8?B?RjFwcFVSWC9FRjdSazRqSGdydzNPbG5pcDZMZGxLbWhFM1ZWTzNVOGFBeVR2?=
 =?utf-8?B?ZTR3TEdCaVcyU1k5cG1VZ29VVFptb1pPY1dhT2pYNUdYSDNpSkRGOFVzZ1Zw?=
 =?utf-8?B?d3o4V2ZndEptVUtmbXFnY05ma21JOEcyMFZrYzczckZEUzFuanRCcW5ydlhH?=
 =?utf-8?B?d1pKNGV0eG5yRTVWS0pCVVVkZkIvcHllM3ByOUFoelRJMFFGbWRGM3BPM21M?=
 =?utf-8?B?MkJkZFV4T1RCZUtZeUduL2ZBMEJPQzJOZjBJb1gxN2FpRThUTjQ1NG9BcG5N?=
 =?utf-8?B?SmU4UW5tS253ckYrT3NjYjBHWWIzY1V5RTVpbllhWjI5K285aHlHVVQ1aStH?=
 =?utf-8?B?eTMzVCtHRjQ4L0ZwTmU0N01pb0FpT1BHQWpNU1FyS1Q1UWM3cEZpdHlyLysx?=
 =?utf-8?B?bXorNzhTMlRqR0U5c0FCUHhaRjdtb1ZZdFFoajEwSVBuS3JQNllTQmhDN0dO?=
 =?utf-8?B?cVlUaEdlb0t1YmRxN3V1aDdPd0tuWEhUalVuQ0xia2FVRXdxQ29GZW5xOGUv?=
 =?utf-8?B?OW1lOTJrSzNpVGhRYXA5TzBqRGcweTNwOWpyYVEzYUo3dGRLTmRiN3o3SzBC?=
 =?utf-8?B?NDErai9oWjFXMzJnbVZhRUhuRURlbnFUc0RJcFZObHZFWTI5bXdCbWJtcVJa?=
 =?utf-8?B?aUxINGhGaTRBeWhZREY4Rk8yK3Z4eFRYem5ESnBlYmRKcFR4L3hWUk44eGh1?=
 =?utf-8?B?dFFmVzMwQ0g1UjFhV1JMSFpHV2hoa2dsMnNMTmtaTFI3Q1AwRi9RUklFN2E1?=
 =?utf-8?B?SVltUU5tUWg2bStuSmM3ZjBBSWp6dHV4aCtYcHR1YkpwNjBXemJJcW9IRmxI?=
 =?utf-8?B?UEdOd094TmxFS0IwOG1rR04rb2llY3dtaHJFeGd2VCtaQWdxWG9YRUJvMVZj?=
 =?utf-8?B?U3pHdkV5bDV6UXk4UmJ5SVEvaCtuSFlxSHQzczIyZmYyVlQxVW5WWU5MbVgy?=
 =?utf-8?B?dm5RaGF5a1AvWnlMcDVSVGNpU1Q1NUQ1WnREREJzNzlZVW4vVmFndzdqR0xI?=
 =?utf-8?B?dXkxRFRsaGdTUVhWWGkwS2dyU3NRUWdXRTd6MThsbWNFU1pWckw3VkJodkVJ?=
 =?utf-8?B?SVVESGU0M3I0cXMvK091T1k4Q2V2NkdlakhpUWk1eGRpZVFHWTB6Zk5wclh2?=
 =?utf-8?B?NCtaUjNxVFBXWTFmdUVvUms4U05iRDhxTHlPYUQ0NHlOdXhoViszajdETnlt?=
 =?utf-8?B?N1lhL3plbWpjb3BqU0ZSUlBJekx3SW9IcEVSSFpDVWx1MnlGYkFMN1J2OEtS?=
 =?utf-8?B?SWI3dDB2QU1zREUwVndQSzFmTFR5N3B6cnY2ZEZiR3VuTlJCZjA4SjhVeDdB?=
 =?utf-8?B?N3J2SWJBWUdHaE1JMEU0NksycWNpbVBtRmlCQ2pXMGxnZVRsNGV2TWNiWHdU?=
 =?utf-8?B?Q0dDMUN5RE1PRDJGSEREb0phZUlnRCtXaUx6ZjdCNUdTaEJ6NTBhQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f176137-c7dc-49d1-489b-08deb59899fd
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 11:20:15.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +k72u75BhtMkDBTs990jaz6RLIWH9pFzSL/ptNh4uK2ntLcBMhRlLSCLeI2CxJuz/zfdsJqP5gFp0ZMAPYz0lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7271
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9001-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:mid,garyguo.net:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2C23F57DF24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue May 19, 2026 at 11:39 AM BST, Danilo Krummrich wrote:
> On Tue May 19, 2026 at 9:56 AM CEST, Eliot Courtney wrote:
>> For example, in the next patch on the sample aux driver you can do:
>>
>> ```
>> let data =3D adev.registration_data::<ForLt!(for<'a> Data<'static>)>()?;
>> let pdev: &'static pci::Device<Bound> =3D data.parent;
>> ```
>>
>> and mint a 'static reference to a bound device, which seems unsound to
>> me.
>
> Good catch, I applied the fix.
>
> Additionally, we could probably reject unused lifetime binders in the For=
Lt!()
> macro, which doesn't help when used with a type alias, but may be a good
> defensive measure anyway.

That won't work, `ForLt!(T)` is basically not using the lifetime binder, an=
d you
do need that to work.

Best,
Gary

>
>> What about requiring all device ids declared to be supported by an aux
>> bus driver to have the same rust registration data type?
>
> Please see [1] and [2].
>
> Thanks,
> Danilo
>
> [1] https://lore.kernel.org/driver-core/DIFBME3GXDC0.14UHJTPD6TTAE@kernel=
.org/
> [2] https://lore.kernel.org/driver-core/DIFXM2N21Q5J.2RIYLU11C5FR6@kernel=
.org/



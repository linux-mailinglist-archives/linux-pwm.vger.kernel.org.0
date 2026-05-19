Return-Path: <linux-pwm+bounces-9018-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDVwMEhhDGpXggUAu9opvQ
	(envelope-from <linux-pwm+bounces-9018-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 15:10:32 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC3157F54D
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 15:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AB5C310C654
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E426A4E3797;
	Tue, 19 May 2026 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="J9QB+Bbm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021112.outbound.protection.outlook.com [52.101.100.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49232B123;
	Tue, 19 May 2026 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195726; cv=fail; b=JME00wWyWNBjlTMStydr4m/9FfuZKHywrcZDzwYiU9iNH608WivaG3jKSRO2FbbH44+AGzRqV51Va3fay/M9YF+F2mqcskH6mIcvfrToHGEWGyH2LJSqpChyBO6FpuwC3ZHC7r+ZD1kO+zGRLqDJezyRGWfvG6K+17QmNFltuJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195726; c=relaxed/simple;
	bh=430kyFKiCF1jVGGOPNR9gLlnL5rv58mPs0/yWDzoA7Q=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=mwRHUphYTzNs888O/bWoQn/i0spksNe+gA8mGKBhHH1/9Ngv0cB0DQTUGZljZxhWEQr1mdN1Mc87Q8ut+mG3qB4d98KUsp9qrJMs7tsvfUXen6to08sDXl9kwttWi0qF6S+1haNE/9QbcJH2PgqYUc8frKFHJT5wcjz+/JWVLLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=J9QB+Bbm; arc=fail smtp.client-ip=52.101.100.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnhVt0bo2/WpZboW2n9iwEh/Eixoo5mvEyufjgg5Mv3LS4b/6gmlZg+FAfskwPtCl4gIPMxBEPZYzhc/6L4uWjUa3WlGQYmxf8X9C/y40cOo+n87o0771EwXv78MlUIrFCeEfkW0/4seFZLBp0iQbSDMTwUXOT7SMkSHV1BPYkf1xwfhNZiDlTzRRMoajuxtRYQJga003ulE4WW46Vp9Rg+WtgNqWtr/XAdC9e4Ti/RHPoAibsU23lzb4EAmJbekenf/OPUq3u3mhcNP8roDmQKMz+7brNPc2s1ti/jbbWS0sQiM8DSKIgilw180DodKAUR6zW/YiUhRQvQaej3jgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sdMjl9P5fgCDNL/9mM22W6Ts2qfK8/PHDF6cdTmKm4=;
 b=EmFoPLBOO5eQOfhNFA+7EN6Crngnt0We8qY8E18o52p6t1AULe+aTHOqOsQ4yDtG9x58k70pmd1iAWz7f7nYCR/Vzx7f1rQzszrFlicZAHCK4jqeS0D5SKxsKiEljud96j7QfFPL11l1wnTuuzpPrsxp7MiCn7WHUkCCfYzFowln2BY1EijRecHGdSBO6faHcmTMwTqg1o+K2dbLYducYmrMNhoDXHC7mAKtwtKD0yhoR7QWqZdKxzrXqjmjmcaveITp/goYe4Wx/dvn2vIOeAdi6JrZzwqIiM4hAojfkhdRqHcV54xKWKPVRasKp2DQyyQa8q1yAZd4U6ysiE1ylQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sdMjl9P5fgCDNL/9mM22W6Ts2qfK8/PHDF6cdTmKm4=;
 b=J9QB+BbmS+6d/w+HXjA1/EH5FJuukEubL0b5rUnSm6rCR+52J0Kdxop+63n049JakX4RK4K+iSrjll/tI81yNGbhaomqJDrJGPiMDVvgR5hqozVibMB8hiEZK0Q7s3VbYpN/S+g8G+vsXPvy9AoIFpcbbBVsrKMHfd/IFbSamzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO3P265MB1961.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 13:02:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 13:02:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 14:02:00 +0100
Message-Id: <DIMO8UGYHA6X.QG8C5E245H5D@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 07/27] rust: auxiliary: implement Sync for
 Device<Bound>
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-8-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-8-dakr@kernel.org>
X-ClientProxiedBy: LO2P265CA0505.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO3P265MB1961:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c18efe-e835-4598-1128-08deb5a6d14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003|921020|4143699003;
X-Microsoft-Antispam-Message-Info:
	Q/JBbAQ5g/gsmW5BSvayXDm0o/otTLekyrLVwv7V2dBKnBFIinyibthIP3N3HSdtpyIRCBR+XCbWqln9m3Ft486wQ7amzjDIFgP/I7VIUXQag4YBbAFH8epbZjmQe5N+aof1m62ua/IVBn4IS5wzVem2ZABsPNSjbITCDUEETSdf+OvuG1rzyP+2YkcSfNx8IVu8IXwf/vUR1Am7Ld+esDWUzPCYWPrd8mX7x/9ggKi285B/wH7hKnyShDvOohv46WAGEOGSSDF9/Syb3zjzVOSrlK4MmSsaA+ciCm25xznQIi7gLMMUql3mtzn1JP8bZcYjbZ3RkScFB5i3w3aV1da30f43f4kyxurr9xz60a32li/1vPKv50wQU8Su09ZFXqZBAiUSPzVjHROGKowlzV6HRjqoHgoivxGlHHjLhN9km6gqa6BaC/oWPWHSeF0dymjJqFWrPyhcUdBlcr2UZrdf7vqr/bJC9TJxGLKL3Y2hpJszOzHMWAhQmyss4qf5yUPpvSs6iEBhzASgp3NaFSHcuX1NEywe8OZiExa58Hdk3dT7cJ0Nd2zHyVffMurovJeEYslFm13b1CHNsRTS36lOY0z3pZ0DTriOtU8NkENvYa7NTRZGZkNy4o4Q0vzcipo9GcHRiIjYDnaeL3M+xC30F/xqpqjpozxCPWSvREa/oVeYbD4cUtqlG1ZB/8hLMhGqlrtqXa74xqzi4f3z3l9OgsjanOhnEf9dhj8x0S0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003)(921020)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3l1MnJsSVdkUVBxV0FHeGtDMzMzd1hrNmRoc1Y4bWhwdlZodEdXL01oVkFJ?=
 =?utf-8?B?L1ZlQ1V3QmU3MFlpaVdKTnJ6T3lhc05WeTlWQUVCcmJRaWlEWHpzVFhCNU1N?=
 =?utf-8?B?clE1eFRZZDMyZDlYRTA2RXI0Zlpscy8xbGJ5aTkxUENpOEt4WnZqTlowMjYy?=
 =?utf-8?B?QUlzWlJ2TU1peXIzd21mSlAvYWJrdnErTmhyYloveE9IcUNRZlR0QTh4Mnp5?=
 =?utf-8?B?YWJycDNxUUlsNlppTzE0ekJwekk2K1prL0ZUUzk1Y1pxZ1dCK2p1cXMwWmRK?=
 =?utf-8?B?a0N2SldJNmhvaVIrc1RxRHZNZkIyYzRDWHlZbTBnSWltbVVTazVnaTN2OGxH?=
 =?utf-8?B?UFlUbHhWVTVUYVExK09LUzZ0SXBQTDZtYzBiTzRwS3NnMWxteGNNbE50WkZK?=
 =?utf-8?B?bHZwbnphS2o2ckM5Y2RJejdjOUVDc1RnS0dCZ0R2MG82aUZYdmVLNTE3aG1W?=
 =?utf-8?B?N3FraUFkN3Z0Y3JwSXdYQ1N1elhFYUFtNWxzbHc5NHY2U3JBd3NlNDNWUGRM?=
 =?utf-8?B?MUZBYnJkTlkrV3V5eFJIcGhabm11TTEyNXlyUkhsUkVhYnpDTkFEamdYWGFM?=
 =?utf-8?B?djdBKzZKZS8zaUVaOHpjdXgzcFRCdjE3VEc4M0duYkJqdWthMUgrQU9DdTVN?=
 =?utf-8?B?ZUMzb2NEYlVmaFhCM0hMWFRhSlkzbEFGNnBQaStVTThPSVFlb2s2SHpYS3Mz?=
 =?utf-8?B?QVBQTXpsRzltN040NmJLWGZ3UWwvNVgxU2dnTnNUS2k0KzV4cno1YmdiMEQw?=
 =?utf-8?B?RnNMSXpTNWZLb21SVzA2OGk3cmlaaWJBbUMxWnBoZmd5ZlFzWXVwUlpESnZG?=
 =?utf-8?B?dk5MbUJYeTlBYkFha2xOY01IQndiOVV3SzM4aFlRb1orQVFhWVBhSWNVWkR2?=
 =?utf-8?B?WGVKNHhtaWNXdkU2cC9jcHAyOFkvdzNBVTBXUWlIZ3QzNDczdXpTOXp2Z2I1?=
 =?utf-8?B?M0MyTEl5YTA1bE1nMkFQNHJPYnl5R0twZnFGa2dFVzdFZ0xDZGdnVWdkTTdH?=
 =?utf-8?B?ZGhuQmdjU3U5dWhXWmR5cjdxL2ViREhWR0JZdkZtZGxTU0dUcEFra2JTcVlL?=
 =?utf-8?B?WlZtUC9vOUZIS1ZxMzNwYVFINnkrTFIrbmo5NmVFRloyMWtVcFNmMmtqRDZi?=
 =?utf-8?B?dnFhMUVVMXh6NStkb2ZFakJYNGN6TmdRT2lXVUM3Uzh2QThiWnB3RmVWamdG?=
 =?utf-8?B?QXlZNlpBMUs1WHF5WnBNUW9qMWhXR1ZSanZ4NkpIc3JDY3R4TWQvVUpwZCtR?=
 =?utf-8?B?ZHNsS0p3LzM2TkdReHVtVEw5WTNhTm93VWFJNlFBeE92Rm1IRTllMFkxK1Jk?=
 =?utf-8?B?bUZJQ3FrK29GVzZjaVpEWW9IMTN4R0hsTzlrcVM0NEVjazJWSlZOVDcweFZa?=
 =?utf-8?B?K0JGKzluQlB6Qk9OOU10bzNjRDJIL1VSQlZuMitDWGloVHptVzNnbDBBUFMx?=
 =?utf-8?B?cDRPbitPa041a2VZY1FlNHU1SHdEZ2NLN3NCcmUyRG9KY2lJYms0UlpEY1hX?=
 =?utf-8?B?bDYrdUxIblRaQk5wTjZSSDJ6emZicTJraUhpbmV1bzRqSXU4ZmpNTGxsRjFK?=
 =?utf-8?B?N29RNU9tclRqQjZvR1lLLzZ0MG5Kc201QVZMRE9GcGRKVVdsRkJmcGlkMCtS?=
 =?utf-8?B?aWM1TjZYNkZMeXdKWTNiVytnWlR6THlpV29GQWFHWjFvNzNVZlk5SUdxMHJF?=
 =?utf-8?B?cCsxeDZFVjIxend5cU1Cc1ZBWTBnTWI3NUtkNUIwTWFRQUN2dFp0a0YrLzEv?=
 =?utf-8?B?TmsyT3JtdWYwODBCYzdjTEpoc0RyM3ZMdnN4dXlTL005alFwUkZ5MXVoN1dr?=
 =?utf-8?B?eitBbjdZVEVaWnRTYngwcS9VT2hzaGlhTm5qV08rRi9XTTdTRXZIV01MaVkx?=
 =?utf-8?B?WkVheWZMVUdIeTU2bjB0M1pyQlY4RDZQOUI2L0hQUWh1eDZ2NTBJZmhKaE9o?=
 =?utf-8?B?b1RvL1M5U2V2RWt0d2VIYjlRZVRqU1BXM2JTbm1rNVZqV0RoMkR0cXlxbFRn?=
 =?utf-8?B?UWZsbzFXTjJlYzE0azVFZnp3WU1LcWJZWEk5VllZOUJwaVF1cUJzZis0ZUZK?=
 =?utf-8?B?Rm5DcWtKSEFjcUUzL0lHWmpHOGRjRVRPMmM3Tno5elB2TTIzdEpNd0d6WEpB?=
 =?utf-8?B?aU9UMEpUamd2Vk1FcXBqZWlvall1enFBVUswZXpza0ZTdFZyV0diSXVnV0Jv?=
 =?utf-8?B?SXJ4dFpWL3IyVW1Gb0RQVHZjRWJDREtIdzF6dkpocE9TZDVzSThYSDJveUh4?=
 =?utf-8?B?RkVaSEJUUnJXYUJ4VUdHbDFRNHZPeHBvUVY3ZVUxR2YyUkVpcWVpS1p3M040?=
 =?utf-8?B?Nnp3UEpvTzVhNnY3czc0RTRWOXE3ci92aGlXWVFOUm5SODMwYmZsdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c18efe-e835-4598-1128-08deb5a6d14c
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 13:02:01.4528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dEct6oMfntl+bkSbacPY5Kl8AcFPgziEmGVQJB8wzIpDBk+X1ykPSWBhqyGS9a/i4GMGXuLIq/nITwL/QX+i/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1961
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9018-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Queue-Id: 5FC3157F54D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 1:00 AM BST, Danilo Krummrich wrote:
> Implement Sync for Device<Bound> in addition to Device<Normal>.
>=20
> Device<Bound> uses the same underlying struct auxiliary_device as
> Device<Normal>; Bound is a zero-sized type-state marker that does not
> affect thread safety.
>=20
> This is needed for drivers to store &'bound auxiliary::Device<Bound> in
> their private data while remaining Send.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/auxiliary.rs | 4 ++++
>  1 file changed, 4 insertions(+)



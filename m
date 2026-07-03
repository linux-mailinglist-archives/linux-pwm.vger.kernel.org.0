Return-Path: <linux-pwm+bounces-9523-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V3pTFzquR2qndQAAu9opvQ
	(envelope-from <linux-pwm+bounces-9523-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 14:42:34 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C406F702738
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 14:42:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=U1fwf8rg;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9523-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9523-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BADF33098ABF
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 12:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0943D6690;
	Fri,  3 Jul 2026 12:35:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020138.outbound.protection.outlook.com [52.101.196.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2053B3D45FE;
	Fri,  3 Jul 2026 12:35:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082128; cv=fail; b=CqccAokVeH4a318mXd30Qlgu1L4nWH6Gt3evFYqRF+gtGQ4cDaDyKaGl3lViHq0Ptas0Vu+lh6jJJt53m7a7KZwOFP6kaJP1LtfJ1rMfbic36SBeaMpZM27MCjHGjZo5fu7su44FmovzGK5P0NvzqLmACQsb8yFgDtxDb8mshT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082128; c=relaxed/simple;
	bh=NVQFFUH5UakwLQJq57mBuEnvXiWyO/Vxtccpl9XOmmU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=rdt3PQrCwljPDz4gub3/kIta1WhLGbpqiqMy7xjXcRTDEWGenGnV6G2r3x4nZvd3EEm04AQQn92OIgFM6b7xqzgvvWX6NWFR6WDJsrfCeDQ5iEfo/KpxNZ+moFL8sGpXi1wZ14pZ7I9mZouNwiPa1IrHeMLwCRYWIerNgi0sJbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=U1fwf8rg; arc=fail smtp.client-ip=52.101.196.138
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRocHFCGyHaKeTTjzIsV6nd4kt0DYYJqTiDD3aB39cD6RnQ+E818zjgCRN1vn2bbZW7SHOqHV1HuxgEhJl8X9N+xD3yL9sOMqCpPJq4etTVTfiH+CfBC/RETh9DZ5bnjFCx2/H6guxLz+cnMhjYD3le/nOSOtjhQXbAZvCem0ioeknaFCXr10o30FNWnpjFGUHyPvuIbkXy8nNSe6RTmoMize+qaAdvE61UIORYQPtJv+x4b3CNjKK3IBSJN14/jQR1ZaaGCFD4jNO5lMzTNU6vtvG+POamLiknI5GmRGG8ifDMiWKxXUC46k67yjoKbhBt8ZQjkzM7cYslbxt3uPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=va5roCpPhgj/G6lyFuTGFV4+UZKu8hBt2ONKF/L8a7k=;
 b=L9gZIgwJYEd7zPDAziFWl7a7fYsFF+CBDQ+8RSULLhsmq9a0f8ccNXKnmdyYigbpFr6QOLGKP3DoFEl/9PTd7Fffat5JaRSJtEarji4XXApIkBB8e08x/OMCBfd6Qqzm1rXjyLZSCCzMP7M33lAv13pzhLrMkNf8G/cbHq04ktMSFX1yd8IvU7zXXgpu4bBpRTS0qQu6pZ6pyNbu19cEwi7n97zX3xwQnFVOFXK3PUwyT8M+cquInV03RZsq35EDKXAfi94eodeF3wkq0X9NslNfzg60rn5hrChtClVzbLvEw7q8YW5h5AQ9O4GmTwV3PRUdQmbeQd6utiuP1GQiPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=va5roCpPhgj/G6lyFuTGFV4+UZKu8hBt2ONKF/L8a7k=;
 b=U1fwf8rgkMCdNyf0/IE+864UoBmHcsjEO9a9CyIkv74R9G2nCDiSJYa3iNulOpyog+PxbOWv022+60TSJ4s1UcEAhMGxMZ6SxDG4rOQatdex5wMV45hKYcEYGIaTciFjiOVrsVm60UPugHw/2nJ2i84TJvk1ZOPmrPsu1IlZtUg=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB8922.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 12:35:17 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 12:35:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 13:35:16 +0100
Message-Id: <DJOXUW6ODKCI.1GLNDU00TDJWU@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v5 02/20] rust: io: add missing safety requirement in
 `IoCapable` methods
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-2-d0961471ae50@garyguo.net>
 <DJOLKP1V1IDU.1GWHOHBG9CS7@nvidia.com>
In-Reply-To: <DJOLKP1V1IDU.1GWHOHBG9CS7@nvidia.com>
X-ClientProxiedBy: LO4P265CA0007.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::23) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: 65962974-2d46-48a5-27af-08ded8ff89e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|23010399003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RSodj1PT/QX2I/fBdMBNgLstHh4qPPZei9DTQ0zZjm1iHrgg01CnsTg6Clwhwnfbx+NRDlOw+ZfbHgwx6kv4EhbBmHRqroUPH6E/mJN9akWuSs5O5aYIKX0kRhmBG69EMxZCqArBW9+3Q1hBTdv4mJTOU8V38l+k+A+tiyMJH/xJa1cx4iD0Skw8zIsyLcT8kIyCXgM1aoHBJGtop0rTWoeH45UPTZVzUysgaQHZnPbnEajWor91WUYeQim3tYtfht4DD4DT+DhbN9ve4LGNmw4fjiq8mNDXNVafmVTFNhGo4ZiR5SXzRJU65tYrI2OdHGIGsLpnZPAg7ony527PxCl24mFznjfrOvK7lZPoovUo4n3ZArNyRisQSROqA58NPCXAOHz/6Fw0osHKeQbK/re1tvZIktHt4mU1l1KKYlgDvL7PXrgxDK1uEw++VrY3If9/XP7KJ1lzr7El1QYERHP0twSLWv4asLB0D5wh6hnhF5yEto/3lLrNikDDfB/Tv/onRUKtzKkrYD42NPLmwpRrhKjBJ0f8gDmXVSQqvVxLvTebFtwz+yIkX6ILl3n9Oifz13j599U7mGB4dodOkzk6Me7m3YIkX+OuwrMNaIlidV3pP7lI3gMD8hqiY4TK9/TDsElM7Z0loV77UFV8lVnbUIbIno/y7vTw6uqIa+w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(23010399003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHRHdU9sRXN3aGVnTER1VjgxY3l3QWxpNmNkOEdWNWI2R0dPODJ5cjNDNk92?=
 =?utf-8?B?RUt2N25la1g1R3ZCT0pLOXBTZjU2VURMbGhhZHlCL05oQXBEa3pmemdPS0hP?=
 =?utf-8?B?UHY5RDl6cFdHakV4UWNCWFp3c25LNUV1UkJkcS9XUWx4L3kzbG01N0pOSHlV?=
 =?utf-8?B?ZmloRk44aFl2Q3dIUzJkcDQrQ1NOUTlIY2FnOWdYUzR4cEJGNXNKNjhQMFRF?=
 =?utf-8?B?Uk9WTG1kdTlNMmgyQytBaVlROEM4VjFKOGRkazd4dHlyd2RVN1VJZzZlb1lx?=
 =?utf-8?B?S09NdWM3aU82dGpUOUFkQlpXMkdpeEVkK3grS3QyTHRNa0orOWp5eXhsWS9a?=
 =?utf-8?B?RmJoeCtjaG5mL1hyalhkdnV4Q0xmTDFWcEZpOElNcnEySEc4aWJQMEg3S1J6?=
 =?utf-8?B?TGpocUFWSnQrZEI5c2tuWTBzRDU1aE10R0ZxdGdkdkZaZVdYMUVtcG5haG9X?=
 =?utf-8?B?MTRmdFl3R3dlRDlYbW5NbitEMXU0Y1hrcUNRc1ljUEZubW9pTjJCcW5yWE84?=
 =?utf-8?B?ZE92WmhGRGFhVmlOZ0E5QVJwSHBKV0tMRDdSbHBabjg1Z1hveFVPbTFwVmpv?=
 =?utf-8?B?amRKNXpocU16OEtvNlRwcUhDQ3h6OVY4cW83QlRZT0s3QlVIU29IWTczSExi?=
 =?utf-8?B?Ylh5ekNqdzlaZkVhQWVza3ZYenVwYTN2TWNkSE5DS2M2MEVNYnY3TWxYaFNZ?=
 =?utf-8?B?anRpbWJaaUREczJoY1h5clcxbVN6amlCdDY2aDNHYStTV0NCMFNEbkdzZGs5?=
 =?utf-8?B?enIzVk1lbGR6bnpMeHFhRFpudXRvV0dpYkFFTHdCdFpLRFRzRlhxNlpzVkx1?=
 =?utf-8?B?ckFDdU1uZWxWQWI0R2pTSTFGZlh5azJUOWdYUGtQcFYzU0REMzdTTTNPWWxr?=
 =?utf-8?B?VldBMFZFd1Z4NWNmMnQ4TURuR2UzcHpLZDZnTm9qcVZTUXdxZ3k5ZEYvclFz?=
 =?utf-8?B?VDMxUHVlb2VrTGRCVlRGNXhPcW1nUEFZZkZ4WUZXcnRLQ1BCSlJGMkw3QUw2?=
 =?utf-8?B?TXRQMCtTWS9wN2FWU0M1Y0tqKzJ1LzA3dUZCRnBqWmJsUDhQNzE4M0N2cDY3?=
 =?utf-8?B?WVdXc1VER0E2U2dOTnZYR0gxaVJpdU1ZUW5PRVpSa24vT2xSNGtvTWI2aUZp?=
 =?utf-8?B?aTRhMVYxZUwydVVwOEVLK0pldHhTZ3NqYi9CbWhUS2I0ME9pdHJDV2lhUC84?=
 =?utf-8?B?K3grd20wWFpvVTZra1RKVnZpOG1LR2NxQ2hXVFNnOG5MSFhHTENEeklCZGpa?=
 =?utf-8?B?RXZrUXFDOGVHOTlhQ0tkMTRKYzZmaU1wbXFIUFRFWEhaT1VtemkrYThLWkx4?=
 =?utf-8?B?MldjK3pwbi9qQUVFNHEwN2krWG1ZYVdRNDRMYkxZQnV1dWE4S2hUOWJiNkdl?=
 =?utf-8?B?YjExSzliWlc0OGRQb0RpcVhET2ZBM1lEUHlFTjh3QWZoYmJsK0JNWjJ5Nzcz?=
 =?utf-8?B?amc5YjIwWklxT1UweGllTGsxUU1CdHVKQ0JhR3hxaWFDMkd4UnVHZFdZZ09S?=
 =?utf-8?B?OHVIY0NHVGkxdTJjelM5TWRhNmh6cXhnWllIRzNhaDhxczdQSW5hT0lTeThr?=
 =?utf-8?B?N1Y2ZmtJUEVxYnhoMjI2ODAvays2UFNQaFo5eEhUWEtpMFZuSzhFcVpoRFgw?=
 =?utf-8?B?cjczdzBVakZKUGtWVE1NNHpLZlZPbDM0WjVlQW9FaVJhbGx0dFBFUlFQWVd0?=
 =?utf-8?B?bWRNaDJ1bGdrY3Q4dlhQSVdQYmdpN0dDTXZQd3Q3MXhlYU9GQ0FNSVY1ejB4?=
 =?utf-8?B?M0tac3dkUXB6Z2M5WVhKU2pYN0xRemNjMzdMWCtLdjBzVGtvamtCQSt6VHZL?=
 =?utf-8?B?cEduME5GcDVNektpV3lIZ2R6QVNRS1JSUjkyQVcya3N3SndlUERVbmszZEFm?=
 =?utf-8?B?YS8xL0hwQ0dicUhwalBNd2hUUzBUMGZ3WlFIKzZhQnhBRkIwZnZkMUQ3TGxS?=
 =?utf-8?B?WXEwTzBtQ01iL1Exd1VOcXIvMTFGOVZIUkRyUENDQ3orV2ljZ1VCTlhBOWh3?=
 =?utf-8?B?ODAvUWlaMUZja1hKZE9rVTFlY2xFekIvMUlJeTY2dHZUSk9Ba0NVYUMram9u?=
 =?utf-8?B?blg2MElUOU0rU3dmL282SGhFR2ZNTVRQOWVOQkQvb1ZPTGMxZS82alJqWjNq?=
 =?utf-8?B?R1JMbHlpVHhqWjlkUUR1K20vZzI4WlAyYnlCMEZGbmJtakUwbFQzR1RtMlhH?=
 =?utf-8?B?TE1IZGNCWVc2a3JwRjdQV014SHRZY3FTQ2pYNlJyZkpRcFF5QXdwbXFaNnFz?=
 =?utf-8?B?eUhIaXdwbkxYblE4cUtJUy95MjM0T3RkNmI3M2ZReDdma0pxYVNIVVp1ZWhn?=
 =?utf-8?B?ZGFKWTVzNjFuZnF2TTBMdVNDY1RoR1p5OHB3c1B5dkMzY1lJQ1lpUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 65962974-2d46-48a5-27af-08ded8ff89e1
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:35:17.6156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qOSWeAPa65NNaXlieGnPwvVWWEDUR2kSiE6ywod6dDuxvsSSpVDXnI6GDn5sseMwnnTP74it7PfkqrqnkvMdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB8922
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9523-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:acourbot@nvidia.com,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,garyguo.net:from_mime,garyguo.net:dkim,garyguo.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C406F702738

On Fri Jul 3, 2026 at 3:57 AM BST, Alexandre Courbot wrote:
> On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
> <...>
>> @@ -309,7 +312,11 @@ pub trait Io {
>>      // Always inline to optimize out error path of `build_assert`.
>>      #[inline(always)]
>>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
>> -        build_assert!(offset_valid::<U>(offset, Self::Target::MIN_SIZE)=
);
>> +        // We cannot check alignment with `offset_valid` using `self.ad=
dr()`. So set 0 for it and
>> +        // ensure alignment by checking that the alignment of `U` is sm=
aller or equal to the
>> +        // alignment of `Self::Target`.
>> +        const_assert!(Alignment::of::<U>().as_usize() <=3D Self::Target=
::MIN_ALIGN.as_usize());
>
> With `Region::MIN_ALIGN` being `4`, my understanding is that this will
> make `read64` and other infallible 64-bit accessors unusable on untyped
> I/O regions?

That's correct.

Best,
Gary


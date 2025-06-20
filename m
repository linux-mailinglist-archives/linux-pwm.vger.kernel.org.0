Return-Path: <linux-pwm+bounces-6454-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F86BAE18BE
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jun 2025 12:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BC71BC05D7
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jun 2025 10:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A6C27F75C;
	Fri, 20 Jun 2025 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MGRr2P6C"
X-Original-To: linux-pwm@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEE8199947;
	Fri, 20 Jun 2025 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415014; cv=fail; b=DFEL9qYvj2WyBZlu29op/qDwK2uGpGEzQwum3n+Cxb7PcWoYLFeldQXFUFFkJQcTez6BoQQtdylQWwO6y3AJwOOEvHlOpTmr9p9OMJD+H/g80XHRZFPCvC8lsZbO8E9mx9vQNjls0IVt42mlruCSKo0M8fCTZu9fwoPTXykPBDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415014; c=relaxed/simple;
	bh=htFXVv+5NeRUMMyKVfBi7BhAV5WFimbWKRd9rbWASyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=apu07wfDABaRgqpaAdxaUfQqCZNGlwpJA9PvI6ms/DANe/G0ifIV/wJkc7TDPxRI1cfkKh3m0IfIu0uSaBHZkkZRYoEPoOV3+TEm3U66hEz+CVhNJlaUY5OwaK+0kYb33koDtZOKFBtR/GapNfEEQAbiZSCu0Vodg/avo96mrPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MGRr2P6C; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhaZzs1og0CJMWiDJxGE64+JIC83ZRbzVKZpNjmzjIhuZCetOkzi2oe1ta9SPYcumIoEHfHfNqK9Hv+A1XKcDRZ4ZPTrL4kDEiaLTTBOgum1QM39dL5tGCbO2oxsyen4pkqccM1BFIwjFBVVMRVswB7C90VA8/Jezt9pRrJ75MXhrooh/nSTeImeZcQXVOVECs1CwYzZKX+Zjm5elmOGzuT0CZQCtuKMRcD2J3Mt5rz2dIOcNu9EfNB6kBHfGZLjEzjT/6ZoZKZrbrUVjDhM8pTe4JHor8OiE5uEJwz3n6OTYKXrOtTWu1x7VfaAvJY0iB+wg/fMuvj+AJVlRyzyvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11nl0cxTkBHTcIiKmfe5Fw6TwvLae3QehlGlQBV5qZw=;
 b=Ph+QqpwksHvgRO9R2dWcFh5hp1UT3GkZi1HUuY+Z0oMrtdyMvZ32boVa4J6p3b/YN8lNS7TlSAEn7keXG+2Z+H8fksMzHC1TfwE3Ucg3hXi4JV5G21d1lnG6sZ+OyeL7pnjX36c+k62tIRXrvJnCVTccaom/Kp4V7K5njljbvrrPOHGAqXX0Hnoqfv7rDr6RnShxN9bNmbFfYF4kjJGR7jznSt2uyqK66XKy8l2WTuCMWaD53cKXiNtBOenk3kRv0l+6DBgIz1YzklRNWqxdCFpYwkZnYsK/FkefP26BEdjA43woGO9Fyrmq/nA5PvlyxO0ccZjh9FOPzFUrIFXIxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11nl0cxTkBHTcIiKmfe5Fw6TwvLae3QehlGlQBV5qZw=;
 b=MGRr2P6CplCbe83/VT4z/P/aBW0lCPNz4EJt5bO2PHt4d9k05+RwTBy2BVorxDv9F1Z8zOQ6lrV4isgIxvpsts0/pB6CVv0SXgSSO6GJVdyMtOghocZs8hUw6KL8xrhjCCPYMoMbNnKxsMoIzjbCE5yJwMbwZfISqPAfaRbPFWk=
Received: from DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) by
 LV9PR12MB9781.namprd12.prod.outlook.com (2603:10b6:408:2f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.36; Fri, 20 Jun
 2025 10:23:29 +0000
Received: from DS7PR12MB8249.namprd12.prod.outlook.com
 ([fe80::eeb0:6d7a:ce8d:a5cb]) by DS7PR12MB8249.namprd12.prod.outlook.com
 ([fe80::eeb0:6d7a:ce8d:a5cb%6]) with mapi id 15.20.8857.019; Fri, 20 Jun 2025
 10:23:29 +0000
From: "Rao, Appana Durga Kedareswara" <appana.durga.kedareswara.rao@amd.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, "Sayyed, Mubin"
	<mubin.sayyed@amd.com>
CC: "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "Vanukuri, Meher Thanmaiee"
	<MeherThanmaiee.Vanukuri@amd.com>
Subject: RE: [PATCH v4 2/3] clocksource: timer-cadence-ttc: Support TTC device
 configured as PWM
Thread-Topic: [PATCH v4 2/3] clocksource: timer-cadence-ttc: Support TTC
 device configured as PWM
Thread-Index: AQHbZ0HQx65y/GwqLEerJm99AExLJrOClJ2AgIo3EyA=
Date: Fri, 20 Jun 2025 10:23:29 +0000
Message-ID:
 <DS7PR12MB8249A77D506DDCBB125ADE988F7CA@DS7PR12MB8249.namprd12.prod.outlook.com>
References: <20250115113556.2832282-1-mubin.sayyed@amd.com>
 <20250115113556.2832282-3-mubin.sayyed@amd.com>
 <hwnhz4yr6vzz3oav4gq7qptejjy3rdwff7iveawaxexf3tbngr@pnrxi6jkpw3k>
In-Reply-To: <hwnhz4yr6vzz3oav4gq7qptejjy3rdwff7iveawaxexf3tbngr@pnrxi6jkpw3k>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-20T10:21:35.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8249:EE_|LV9PR12MB9781:EE_
x-ms-office365-filtering-correlation-id: 58980ac7-35cd-4147-905b-08ddafe48018
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?VFyflLmlO3+aGWHnKUAwouBTew2niwiouOWTet2y0G9+SLbzaZ9Dp+P0yF?=
 =?iso-8859-1?Q?K3F9ssrX0zSk0AMNaELUnNeu6L1bU29vXLAuJjTsxK4zTtG+Vy4hpV8sd+?=
 =?iso-8859-1?Q?zpaM1Nyx90PTt3q3TQzMeVjN9E/DO9rVJtXQ67G6AP1oxSanwc6CCm0t3s?=
 =?iso-8859-1?Q?yd5NCV5TrEe/U2JWXQfhs1Ws509Sjr59mWi4ni8BvpjI+vqUq459l/mK1F?=
 =?iso-8859-1?Q?qydGLgJ2SLLW6sy4EvrOcBbIKL1JsWEBnSRCH3jfLs8XpB5VZturtTDRHg?=
 =?iso-8859-1?Q?IxmXpgWyyTFqKxcqY8n0BCZ3Apy8D0XLudlHB4G0m8tiUKHcwkzcu0vLp1?=
 =?iso-8859-1?Q?21agjAiL5T2ZOSMl9dDuMOefghokfXlctHu5dYHdb7FL8bfISDih/ywAyr?=
 =?iso-8859-1?Q?fCGXfFBkxRp22ABAo38yl7QeaF4oBCaD98r4iVBbCsnFYPogYbwaOy8Ffe?=
 =?iso-8859-1?Q?E5PpLTiBksX5m7J3/jnliA2knqU+ia84Agca9cO/8n/2Lwl2HP10+nRHVb?=
 =?iso-8859-1?Q?rTIETToaPHzErlB77ujASfjuixD5wnIMI+mYGS/VK0KqY5B/H4AM9WmY9z?=
 =?iso-8859-1?Q?3CF//Rdre+kfmWEamLj7YTS5NcWIUehoigkOcjDrXG9qKgD6/lUL0QhNQd?=
 =?iso-8859-1?Q?3ECpuvWXL7vOAR3TqYuhhrK6aWxCop4VVRGTfFl/8DxDsR7o+FC0x9E3IC?=
 =?iso-8859-1?Q?p7OHZDxCPqa+gQKxXF3jjyFaQG+A3XjbjhNLvaqJOP6Tf7xa7QCa+IqDjB?=
 =?iso-8859-1?Q?XwZPQ98O64Sk5w2jMXfp12yxyX0hMAFPuVwHFaKz60eIYvt0ZeXtwrmnlO?=
 =?iso-8859-1?Q?T2l4mVaGaa+LDoiaY4b8X25J+4M4m5PHVGpKpv8+Er2RyIZ1uSTMJ4glVn?=
 =?iso-8859-1?Q?j4tOUPvF7+Cu7JNC/npVB73QTe/lNynQoAJLdLz8YLeUUFnKtriyz9Nttp?=
 =?iso-8859-1?Q?qO0kIs9EjeOGslEymR+JagGSPSjIvptsdccKvKwb7GPnaWCTh7vBME5mTc?=
 =?iso-8859-1?Q?6zBf1w4zto5tZoupEJrSMgFej19iz1W20xURS3LZ9iv6A/UxTE8LxP7RmA?=
 =?iso-8859-1?Q?rKB6Pp4t4ir/E3iCYbT2PaIC0g4l2fiGrC9xZ8y0HVCIWzTtpGlJ2rnH3p?=
 =?iso-8859-1?Q?CZ/Prj3kmy/GlsJL+IQ9cU+yP+t3NGTe7GtCFzZ+ISTweOCYKYIus9rH8r?=
 =?iso-8859-1?Q?fZTze2X2f1/mtaeAzHoh2PYhA2CVSTwiakJT73tDPhMPBhSti9wqY3crkt?=
 =?iso-8859-1?Q?xCHoIweN+J8Iha1pK5affZfmv20YgOI9NYWd/EurX6tnl2LIwqaluy1qcL?=
 =?iso-8859-1?Q?pQP2XcPH3AzrOPdeaqhxeblgG1+Z3hfwmUJwzZ6cDQ459FbpsXNb8rsMR0?=
 =?iso-8859-1?Q?Hy9+o+ukaSZg4T6KQt2LbTpZzf9k0ipJM8+Sj0Eg5BJvNrjPR+oveGbSgK?=
 =?iso-8859-1?Q?qT7eq7aaYWtFER9CceMXI9H1jAWL83ZQufMi/hYz5r2mxrDF4XHj9+Az4A?=
 =?iso-8859-1?Q?mf+cCtIO29N2+DIV4JZIHXP0r+oqPnQ8n1+LXoJaWAPvsJkRbewUp8QzkR?=
 =?iso-8859-1?Q?6KZDz+Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8249.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Zfett3ImZCqcJNfUSp3sSBCavXhe2WvxDiQg8nlzLLQNd0aZv5Kv4zgHG/?=
 =?iso-8859-1?Q?qmP3qV5Lt7g/MsusKcOB9Bi+JthA+8U+lM0L+GnHvGn44a+E95A7SnJGuD?=
 =?iso-8859-1?Q?9I+Bf5Ot5uQFfjeORPaqyCXf33VuqTc3HcJBYaMBTmPizXCU7JkLFXml31?=
 =?iso-8859-1?Q?Rruunwnc0VTn2TF1UwuXWjlFexempQZQXWDloIvevMSJVpQSJNc4z0UaQC?=
 =?iso-8859-1?Q?IVj2cYKBnS3IzOx9FkHocVRG4CAB4ncS8UjJe2mdvbJlVXgGKtqQvrOYdU?=
 =?iso-8859-1?Q?vk2oyOEduiXK/k9mg5gNmnhN4pA/OSRXcQ+lVXmmctf+eltwTQ73ePEuVm?=
 =?iso-8859-1?Q?wZHEYMi9HZw45ZguAZozSon/eJY/i1Y0nlay2AlkIiZ3vwBZm9XlUp1jhK?=
 =?iso-8859-1?Q?d9aywwkKdBwGCAIauiNZ3M3Lnyuh8HYybDu163ExBoD5Dw+tNqTTLWIY/w?=
 =?iso-8859-1?Q?SiqvoptzHjjxmWehZwqdd8sgfq/GoZoLx3pTHwBte+7zK0Ifj/d8g963g+?=
 =?iso-8859-1?Q?PNvOhQQguNNm0CDPaxI6ticd2QMGd0+K7+3Ub5gbBAoeSdpQoPznbDGrQj?=
 =?iso-8859-1?Q?X7hmb8MDLn5SVsoaN+VhpmVYcb4WPC1quGXuqN4UDgTJi9q5mtzDAFPudk?=
 =?iso-8859-1?Q?HRm63IlWpe+b9Qw/6vQmaXIQucds+Bt99t8mkTdefapwev8e1VKR55jXcz?=
 =?iso-8859-1?Q?wg8ECrInjcbPLau//X9/TTmEJQDzBJtc3E1Z+CCpYROS+G0lU907U22bnX?=
 =?iso-8859-1?Q?CqtOB6OWjp66mRAl68nvbXE8ItV4iYi9mblScVr8WQAqKtgDI9x4ue3Dph?=
 =?iso-8859-1?Q?SUbiBkqu3PzL8SFSeb0xFp3t2vJUbOaRdmOUo9JXuOFFsfL1CP9piC6I7x?=
 =?iso-8859-1?Q?xtpMRc08n8yAPXym/2YRxCgrbA+BXR7QfW5AMq/hcnw9fVnSytMw0NmVRM?=
 =?iso-8859-1?Q?oZWzHEX4yQJAMu9VV+Z5uTbkWvVzL/5ftcwS02WHScBxnP31CNgOMJ/Mw3?=
 =?iso-8859-1?Q?4Vd7H6kxi7wqG2/FBP8goDmsDYJIDJ1FFxpzyV0rqO9chYis8CfZw/0lnh?=
 =?iso-8859-1?Q?dCFdUdA0pKyldATOFc/Y4xQwiELdjL1UCVwdkRD3Evq66Bvw7aUwPPHaqq?=
 =?iso-8859-1?Q?si1weJeFK2wg8IqMyR2joIxMgOb6XOKRX4oIRa3Zd+dx05ZDyJFL2tzOHZ?=
 =?iso-8859-1?Q?XRCDWNabmpwkNyOQ7kUAypiSWSrX7Zzi9iP7vRq5m7VslR4tIfveLSGC8F?=
 =?iso-8859-1?Q?XUJjqbzrI32rLcgj2TjbGrbaHQxNQR66ZK+x1giKus8g1o8Ekvzs345Uo2?=
 =?iso-8859-1?Q?BDXhk5lZ3Ts9YIsWWbhsSbKh9EoPpbA/nJl51zWtmgVU+cRtvcdIwfESLK?=
 =?iso-8859-1?Q?MUsKcS8BzjxlzFlJ0WhYFChuSJPZE5iB+/uwSS/gdA4y0mO/T7erkD8i6w?=
 =?iso-8859-1?Q?d8W+Hz9Cv3ooe/fotIJmzGhzMJSVf7L0BzciFSLuOrr9ujJdclM8EU6gWn?=
 =?iso-8859-1?Q?o+ZLiunAd/aM57Oqt+nNAh3/4VuyaARj3+0SDH9+nKVZc0iy3wMF7bWQNp?=
 =?iso-8859-1?Q?LPcveIPOidiIpx5lnJokmJRNW3FSdUorJOofoc+CASN8MKjkpAGmNFh3n1?=
 =?iso-8859-1?Q?KUz9g7++EJrAQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8249.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58980ac7-35cd-4147-905b-08ddafe48018
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 10:23:29.2816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: os0rf8mfjp75G8B4zFt3COe4seyh9ki8XcE3YDKD4i3v9gTYIiEXfuw7pO1VjTsG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9781

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Uwe,

<Snip>
> > +   /*
> > +    * If pwm-cells property is present in TTC node,
> > +    * it would be treated as PWM device.
> > +    */
> > +   if (of_property_read_bool(timer, "#pwm-cells")) {
> > +           #if defined(CONFIG_PWM_CADENCE)
> > +           ttc_config->is_pwm_mode =3D true;
> > +                   return ttc_pwm_probe(pdev);
>
> strange indention. Maybe use
>
>       if (IS_REACHABLE(CONFIG_PWM_CADENCE))
>
> This is an unusal way to bind the PWM driver. I'd prefer creation of sepa=
rate device
> in the PWM case. I wonder if it can happen that ttc_pwm_probe() is called=
 during
> boot before pwm_init() completed. Or use an auxbus device to distinguish =
between
> timer and pwm?
>

Sorry for the delay in response the upstreaming of the TTC PWM driver was p=
reviously managed by Mubin. Since his departure from the organization, I wi=
ll be taking over and continuing the upstreaming effort.

I have reviewed the v1 to v4 patch series along with all the associated fee=
dback. In response to the concerns raised regarding the use of auxbus, I wo=
uld like to propose an alternative solution: registering the PWM functional=
ity as a separate platform driver using a distinct compatible string. This =
would allow the PWM driver to be probed only when the specific compatible s=
tring is present, while the timer driver would be used otherwise.

If this approach is agreeable, I will proceed with preparing the v5 patch a=
ccordingly otherwise will explore the auxbus device please let me know your=
 thoughts.

Regards,
Kedar.

> > +           #else
> > +                   return -ENODEV;
> > +           #endif
> > +   }
> > +   dev_set_drvdata(&pdev->dev, ttc_config);
> > +
> >     if (initialized)
> >             return 0;
> >
>
> Best regards
> Uwe


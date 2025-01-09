Return-Path: <linux-pwm+bounces-4558-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF65A07186
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2025 10:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4468161061
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2025 09:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E1F2153C5;
	Thu,  9 Jan 2025 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="JVVATu4o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010023.outbound.protection.outlook.com [52.101.229.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C18A21518F;
	Thu,  9 Jan 2025 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736415190; cv=fail; b=bCbumQnvPcfARK1TEoCjOU+t+RZ/9r2RwKhEUMYOT03zYlXX/cE/F2Ft2aw7mgmkb5Lh78fQOKmTNlsHu3ZUpdJvAXxoldjTO4girkl2ttZ7DfCILvLMoeqRymO4WlyTF4udVnOFiDHK1FqItNQyfSGxhtkt3J6lKWb+dV231sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736415190; c=relaxed/simple;
	bh=D0xUBJY5SDknjgrqZKVvyp6aHxv6eHvaYUymL3vVTKM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CCMYKA+P8ckzP9MGg0d6aHJYiiu1UlksDcfzeezARpSz3K1vvPmq8yXTXe4CKvoWUDNyaIPD2DSG6ro4OB/vG3j4CatPdd43jBB0CpgOmXgfDNbzX9NWP8S+oh/yB0b35YkPdyX+wdLeCc0ANz+AYCxVM0mLkTUC+Zsy190CO/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=JVVATu4o; arc=fail smtp.client-ip=52.101.229.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNrVxVO1Mpznhpyrf+Ca6gXZYiyBSYTv0uveoNvL9pe2FoNsvka8ksf9VRzFqGl29B7t//QZsAaYxmdDd4GTCgo9M85ruIZuPfSei8rXbZIuB6zyeejR0P5AytrYnG8MVrx/DpPMm2k6UxHUf4jYairG8SH2FbbZMHSLtLM/ZIKLCtazXO6hcqnPL9Oxfi/1gw8BBwGS0lTjxp0yBkpmKWM0jBH0jixXngU13TtdbYyrAMH+tp1Mq6kHWYMIAUj5BV2XN6KWiJqLG7rjdhneW1yNSiRs71D7+//Jux3ozO8GapyvLrXWzsIjhp9GuwVK0QI6hgRURUYOXamMhHvXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0xUBJY5SDknjgrqZKVvyp6aHxv6eHvaYUymL3vVTKM=;
 b=oXjAg6caPBnbjqWmM9jXuNOcn5DuvWqHiK2/Yfa3NO/nOVhcMlQRNLsmJiZFKdxjtCHaWaYa1CZl+Bwgs60hnzsFnYkhpd8E2j0otaBBCH/BJIbeiQc+iUGJm6w7YyPjgfedK0FQ9FIP712HkQOoRT4OQH/rN4UsTK6+U87gDCOdF90vjrNc7SOxdzY3YLPrDTznwOVksctk9e3nYrGLAopgasGMu4Je/sRP8gkAPSCLAnaL9O3eqbyv+GriuHr1JETgaqWbYkf7YlGr5IlyUCtX5EG7j2kdCcGaWMmC2NCGpQHDE0RiqefF8ql2XGZ7ZG8/ZOwpNplUvCw28lxxug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0xUBJY5SDknjgrqZKVvyp6aHxv6eHvaYUymL3vVTKM=;
 b=JVVATu4oUwHd2/FJb+wKbvp45V3h3YXbh/gquWMOjcCCSdpRDV8Je4N7SREZbP3FHhod2vcpgpcALd+A3QkHrztV49nk0r8XVNBZD3nlU/p7DNj3hlVnOnZXRnDVTO+NQ2MmAiRMx2CWm+JIDg8jUbcRXKw+vzNLst5inE5UDWc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS7PR01MB11502.jpnprd01.prod.outlook.com (2603:1096:604:243::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 09:33:04 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 09:32:58 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: kernel test robot <lkp@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Prabhakar
 Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHbUIfEye5JKGoBg0O4godryy/UCLLsKj8AgCDikqCAAUJZAIAAAFog
Date: Thu, 9 Jan 2025 09:32:58 +0000
Message-ID:
 <TY3PR01MB1134690173EBB583582DE8E3386132@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20241217132921.169640-4-biju.das.jz@bp.renesas.com>
 <202412182358.9wma1UUE-lkp@intel.com>
 <TY3PR01MB11346CC402843A628226F5C6186122@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <b7woae7iquvuzs4vcollns7qcyand4ginrbjqs75bnsiockrjc@c4pyody6zdcr>
In-Reply-To: <b7woae7iquvuzs4vcollns7qcyand4ginrbjqs75bnsiockrjc@c4pyody6zdcr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS7PR01MB11502:EE_
x-ms-office365-filtering-correlation-id: 7d2aae43-04a7-4834-53c5-08dd30909a8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Aa1HVMfHKwv3YjNdveSAxlBivVgPpX6RGkWw4qIjHZv3REbyGr3GdaagSi?=
 =?iso-8859-1?Q?+UAH1l6GV8nc6Dyap9Z/E3+bJVl5QIvb/TG3eMcxsCmkHGQ/OGeTMuYCWV?=
 =?iso-8859-1?Q?0SWFPluiC+Oy8/KT3aYgsU1oIkNm4fIrOfNjICJkoLnIXsxdz4dTtg0yAN?=
 =?iso-8859-1?Q?8cMGdaspl4Mlvkm33FzFn4m6yg+81ExuaPbHHAWn/eptYQ/kbW5HPa4cvK?=
 =?iso-8859-1?Q?n6ejDcJz9KDv9sjhHDGdK3gLzxYMx/RQd9mdt+SBuClwXnDmZUee3Cz8J6?=
 =?iso-8859-1?Q?iisXM8mDAsgtyd4QuaIMzzIf9kHqWkucjSy+QPWq8NeROu+Gvq0xYPPnsY?=
 =?iso-8859-1?Q?EDdT9NPSoGz4m3+zcT3TbZv4sHXG17riENilFG+mhB2H4z2u2NlRRvC0rW?=
 =?iso-8859-1?Q?b24/es0mVRt1Or3nXfY+Ng731/bAyfSRMyv1gj+BF2CbpHLV51xq6maSH2?=
 =?iso-8859-1?Q?zY1cn+29v0sV2MRb77LgAf0fb42fpihHtb41miNS7J3agVtRkHiETJ/Whd?=
 =?iso-8859-1?Q?Sk9d4sjTFWSvHYaM8EIKqpyo6txN8WfWZzru8GrKo+MDh8YdxFvW2uEAKU?=
 =?iso-8859-1?Q?5V/bDj6WSanligz20jghW1cFUHuGvg14auI+6hW0S0k6wOa1xXS3iSInKc?=
 =?iso-8859-1?Q?rqI+VYSZV1x/oHBifol4dLhos86NJ9+gR2I1CwOfO0TTmvzAg6NaaNClFs?=
 =?iso-8859-1?Q?CYgMHA8s3jRnitdUMPm6sOVxWyfap6/q3iQp7AyrCaaE+Z9/DZqSZrjFVA?=
 =?iso-8859-1?Q?ErYPM7rPH4dKI/dwozDJ/O9rhhIdMcqoquSKrDd18K3Bb8mfrPV0zRceQA?=
 =?iso-8859-1?Q?f5PKLvhBCyhBZT/22y1bi5waeQRlzlIpxV+kpV4Jn6DXh/V4JMSfdbrlDA?=
 =?iso-8859-1?Q?2a72GHprOM9v2Ygee89bbHCmfoDukPsn0GULHUeChLNY6sMOyjWhY79D10?=
 =?iso-8859-1?Q?Zuaitn8o0jRBrqhg99f7UTCso26Pde2RWHsMaR4cCdsKEQvMt3O3wPqfNu?=
 =?iso-8859-1?Q?3R/fpLtqTpbzLCyVpDaKQ0ABeZIGc9PkYMFkhmFxS3a15fe4lbkzPbSc/q?=
 =?iso-8859-1?Q?x8pUhDa4tJmASVCkbTLZXQNNEClnIl+wMiuMVgcyODrO2EkRGJ7ARpa4ZU?=
 =?iso-8859-1?Q?pcPsSQ9Nl+4qMSEmqqAT/l2UuWgoW0w2wCfOZU+ZQCWQ7C3gTfWq+/LNEt?=
 =?iso-8859-1?Q?viKHKBxynrk06WULPIA8j3/aguhmWAhJWIKK85Sa2OhROt4G+1DaummJlA?=
 =?iso-8859-1?Q?bTnz8PbMtSMiRPYg0zqJX5BED037l+reupHfK7I07NSz1RT9+Uz6q8iHnN?=
 =?iso-8859-1?Q?LTQFRL3PdmBUcHTcnRU+FSpJxAuIhBq+9tlCIpQF8NN1zaVZs3vI21GUYJ?=
 =?iso-8859-1?Q?VWHeSZU6Os3KWV6Crk0o59/wAmCXFWyj2uwqvZ0ONjq+4eQlZ5/+6Kb0U3?=
 =?iso-8859-1?Q?uziwL596GdRIfIW3PL1ixV40IVk8h4DQuvhFPjR+rxsonsM528F/JkziGB?=
 =?iso-8859-1?Q?Vmxrfca92Z6q24NaSS/QpM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Z1V6ZrTr5eqlhoYZT92E9Ntf2A1BvyCuj5ABblJ6LT2u0N9bjtLAr+7S4Y?=
 =?iso-8859-1?Q?BMlg6ia9V6qKTS7dZZF2cyj0/PQQLvMV+xnT5QDddP9peamo9j0ZPKgVST?=
 =?iso-8859-1?Q?+H6NSKQabgH7ISciFx0fSHq62RA7GCnsAMwY3Pq7vncWx+/p44TI72HJTk?=
 =?iso-8859-1?Q?XK3UK6f44I/qGC+o83U9qH1zR61xVVBqCYr8kTXIgekFtjljYsWtdPzx9N?=
 =?iso-8859-1?Q?onEvntX9ZS6VXz/x/2uWfQjg7QFVmWMkjSEamAeCQ3WnIJZLkFS/XrFw3b?=
 =?iso-8859-1?Q?YIaI01wiPcUJdf6lrabP5YusLg6LrOwbtGk9d+uhzhnbHIfOBqUd1JFL16?=
 =?iso-8859-1?Q?hoUfGacqKtOK0ZmVQa2kerBFD5UQNFeJfxWnqrdbbaVqjp17zdfGCW3ohQ?=
 =?iso-8859-1?Q?S9+OlZ84sAVZ5kscf0/nsyvZ8ms8pjdBG/tMfVj9iY7FJt8UeEwUNF59jN?=
 =?iso-8859-1?Q?ETKz8kOuLAOw4VuVThOwQwy3yMKux7r/vxAEcgGTbJ/8p8ExyuidrSOKKb?=
 =?iso-8859-1?Q?WBTOVPlaXpqog6pmuxZCTA6OODDH1FrljYQrho2dQTZPLfGLrUxZJy1HYW?=
 =?iso-8859-1?Q?J9D29GE6SeRYzjqi9K0Qs6Ar9owTFFLEu4yjdrkX95pFk7RvOq1+IdfBoF?=
 =?iso-8859-1?Q?mY4b9oUngwtjhIp0D/C/JGMKzL34zyNf5Taumd03GSodyCMH3QtAFYFnIS?=
 =?iso-8859-1?Q?YsHF1I8Gzh+WjjI1HRQqOUMajkAH3RfqTq/Em+naA7T6f2jTtdC4qxmMXO?=
 =?iso-8859-1?Q?IhmoGoIuywWJFnzFBSyNCy21URg/M9fiOQSRhNs1oC+sMv8t8/WsSNrp1u?=
 =?iso-8859-1?Q?og4Fy66fzFAKYkH0F4jti6lbNK+XWBrtsOHM1i9Pj44EwXhIXnbcBFb08M?=
 =?iso-8859-1?Q?06D2IwtFq0ZSmmwCBLBdDO1yB8xKF/41jPBgN3V+/ymsQ8HwDFvzR38S96?=
 =?iso-8859-1?Q?grCqkdBHaTKjozjKSFme4cGjnkOu4GcJN7AyLVbCucXDdOYNcRkcKpGYTQ?=
 =?iso-8859-1?Q?e9Z+t9SSHexV+j0NSR/ZGOSmHscbx+zJZKNU2aoCYXATJ2Zv6haW6594O5?=
 =?iso-8859-1?Q?IbOW4c0yA+udQzSKubLLhEFm7kBESiM8tOO6h4oKNMSeUryprBgJeoS02g?=
 =?iso-8859-1?Q?Oe//njXEYymFPlChowFHGUv0zblzsMstH+uqSm9oGGc1KJP0uo3dXvg0Cb?=
 =?iso-8859-1?Q?qlnMrvTkW2t6ZFdEgicSsoMNsaFQ9tU3WCXRgsD01pKzkO6bLty6ky7lOl?=
 =?iso-8859-1?Q?2ooOOgaQjTuEvKfX4naDSaOXxVq5rF0S8FGlhhULGCIRcVguT7WtHNl4B+?=
 =?iso-8859-1?Q?ig1zcm+4M3Uh7SkVVq2gW43bd2kcje5cHId7I/SPjHAPZHbzP3tx9lnWZ7?=
 =?iso-8859-1?Q?4Z2myCz+rD8Br0nic87HB6du4siJgpq9Njrm0TbYm8s7kFaaVPCH4pwNrS?=
 =?iso-8859-1?Q?oB1w7FGKakcPyUl/Aa+qtLnmSIBTc511egxtkXMlqZ9UsZG6Kmh3VzfE/q?=
 =?iso-8859-1?Q?LOhFtl1YjELjqvw8ABz1y6GN1roA1LtnqvclctlHTwdWTNmVgR6uH+ZNAi?=
 =?iso-8859-1?Q?HTScji0N9Hx9PSRVXhdKjkBRJoFhNOT3UqDaGWIneSoetvK5RRsK/IwGy6?=
 =?iso-8859-1?Q?ZZqc3rythEt6l/WCyUBeWIDjnd9q3shWIZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2aae43-04a7-4834-53c5-08dd30909a8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 09:32:58.2646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v8C3y7Xg06DpzDfdsuXXd1kQoKhe7gVBaa7LzTztsT0/wzmEtD0AKIurFplzy7drMLuYA0+yeT1+RD8ngZw23a425sTt15gKtfI62rt6qwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11502

Hi Uwe,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 09 January 2025 09:23
> Subject: Re: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
>=20
> Hello Biju,
>=20
> On Wed, Jan 08, 2025 at 02:13:09PM +0000, Biju Das wrote:
> > Please let me know, if there is any feedback for this patch series or
> > any new API to be adapted in next kernel version which simplifies the c=
ode, So that I can send next
> version.
>=20
> I didn't look, but if you're ambitious you can convert your driver to the=
 waveform callbacks.

Is it ok, after the acceptance of initial version, will switch to waveform =
callbacks to enable
the users of GPT(Reason: lot of customers are using GPT for backlight for L=
CD panels)?

Please let me know.

Is there any documentation available for waveform callback? What scenarios =
we can use
Waveform callbacks compared to traditional one?=20

> Otherwise I didn't take a look into this revision yet (also because of th=
e kernel bot message).

I just need to remove unused variable, that is a simple fix.

Cheers,
Biju


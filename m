Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B6628C760
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Oct 2020 04:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgJMCyf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Oct 2020 22:54:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:62981 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgJMCyf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 12 Oct 2020 22:54:35 -0400
IronPort-SDR: +LG2arZHTUnvfqz//0pPebqn6xvEsfZIRvQHTvREEQq9H8i87vB4moCO+2AzNn8TEGhV0xJHm4
 qmxvqz4QAybw==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="165948279"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="165948279"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 19:54:34 -0700
IronPort-SDR: 4gJ1lZv9krlWzHfXrqDGRyE6kCMmiBT1TgECd94JHqD9LJRk3Lfkkaa1PctitFjcCjyDjoXaau
 e4794HUR8zcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="299467313"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 12 Oct 2020 19:54:33 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 12 Oct 2020 19:54:33 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 12 Oct 2020 19:54:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 12 Oct 2020 19:54:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 12 Oct 2020 19:54:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNUOv84CNrsUG/S3QT9KR9otfOt4NIeNik71Vu6+vnFPDkgNlTqSEBc79FGWvu/ZtHQM/RgksNoSYRcMOojztDYyKi+57HhU4HEQTI6N48hMcRU84RU4s2QvwbPhLo+c4sZBPymbEw4jb3oJeEgG2E7CKIVBlAIQnZ/KjVOTd4PB/8YmSVD65nyJeESyuy5fhq6MkE+b5ahW+sjDk4Kyml+p+jYgYgFrMDIarIEMy8HI40oeis9ML0T2bhYn9nYz/9+W1WwR0l6bcgzzuCvXgY7rab5W37h2pgS5FoUm8FwDUpU10ayF2+WczSz/ULuKEmmUoppLFc1yo5XpE4gNag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwfEx3+pckX8jFNJ5qgfr9UdKTahLy0yxq6TYYe1MaA=;
 b=mmcFCGyzoJOMrVTBFW0Qw3P3qpLFl9Ls7bRrLvsP+fRKJFQTUUWb2IOUfO4v00ZeWUW7HY1UrsRfaoUod5/gEoqq1Kj7Mt9yHYBuewBxUbjHDH0XWFi41/W3Gp3f9JTS2RJzw+3rb5BG3t7ahU9SjsEWVqrMwliDsX+NS3C77KZjfTf8HlGXcTKr1wUvwuByI6pwf+4uuQNBmn9so+CvAr0mBonW6T9abrTO+ocPH7wwtLgRdgkcyeXhmgBd0uPiUyld/RNjblMq3PZaCVSdAcpTBlTcPvqhxvtUS8GcDG3/T3qbTNbrcBJuUKxpb0BvTON0AuvwNEjoeOKXFtfhHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwfEx3+pckX8jFNJ5qgfr9UdKTahLy0yxq6TYYe1MaA=;
 b=ZIvhyHKH06ejYviIk7xdU7qIRb+5T/Py46ATwEwg9/8abcJ+kshr5D7/RtMZlKNXjtQssZp9Mh/dG/9j07cEkZuXSMh6vLkFUFgAgg27HU4WkO3FR07fkmcaPV4KLZeb4f7maITSOfXRrz5BcnnS1cQ1MqlSA9TyVM+fYwWv6RA=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM6PR11MB3017.namprd11.prod.outlook.com (2603:10b6:5:6f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Tue, 13 Oct
 2020 02:54:32 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::7448:c067:e80d:3c09%3]) with mapi id 15.20.3455.030; Tue, 13 Oct 2020
 02:54:31 +0000
From:   "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: RE: [PATCH v10 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Topic: [PATCH v10 1/2] pwm: Add PWM driver for Intel Keem Bay
Thread-Index: AQHWnNpnAcsmnD9gzEyxRo255sUQh6mMn0AAgAe/gwCAAB0pAIAAYKUA
Date:   Tue, 13 Oct 2020 02:54:31 +0000
Message-ID: <DM6PR11MB42507506D412B7D7D29DB01CFB040@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <cover.1602090900.git.vijayakannan.ayyathurai@intel.com>
 <a8cb129092283cb6415e56b928293ef7121a851b.1602090900.git.vijayakannan.ayyathurai@intel.com>
 <20201007205734.vguookvp6wt3knuq@pengutronix.de>
 <DM6PR11MB42507C555C3F183ED6EB98ADFB070@DM6PR11MB4250.namprd11.prod.outlook.com>
 <20201012210112.tdca3so6dzplootw@pengutronix.de>
In-Reply-To: <20201012210112.tdca3so6dzplootw@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.111.146.234]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccc0dda0-66ba-48a8-65cb-08d86f234f6b
x-ms-traffictypediagnostic: DM6PR11MB3017:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3017F2FD8BA22092CA0BCD97FB040@DM6PR11MB3017.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XoEeCMoO3Jaii0tECpmxussC0KCtLwsQKC6/Svcz4l+qkKChWnrPZbMkXMRinMPsKaYevfK7lQOEO+UmotRIN3GEbXsJPbuSWdxR3QBGRNpmaUtJiPsB0shhNAs9X43MNSddy6relBmkb45qse4nVGh4rskjell3P87yoKV21rsovqMoYAjzey1QFPnUfMlTD2Nb6RnXglGq0TUwstmNd5xp2U0o/PnNlfNyT19u+EaM7HTebkI9ef9bB3DxhKWkbZgUEA9e0g6vVGJ8k5qtbVXUXdtkK4IN2L+9DU1H3b+IFLjpjNrZXO31rE5VbguJEXJp6Fv3yxdiQSWd0ah0UAS8oxjJykf0P80zZzs40Fx204Jqv5R804xqVnWTteoyq6/CILjHG2Aet7RW++LEmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(55016002)(7696005)(186003)(53546011)(6506007)(54906003)(478600001)(966005)(2906002)(26005)(316002)(5660300002)(4326008)(83080400001)(52536014)(76116006)(8936002)(66476007)(64756008)(66446008)(66556008)(66574015)(66946007)(83380400001)(71200400001)(8676002)(9686003)(33656002)(6916009)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wE7Y3tRbMAjSl/4IFalEA3DgcNI4xgJpg7/i2fXQcLmRyOtMNjqK+CYvS4Yhb7PbDlszMmmp+g417/yYcW1LMz4Q7kkUWfTVhzabIvESlqs++a1xCj6pvwS/wK7W0nAcBP9LuHqzZNkJFwR7oamo6mNSNiC1wlRR2X6eDOz+G/ye+YiMhs35nljDbx2SUSXDPmeuLM+H7nI2evvx31a8eGP0l+cNhXLOHi3VKtIKTIrG19i514/a9L7m6mhsFe8KQAQ6oYwzzAKe7Vl4l/IjxTM0hB0hGRlT05rL1tIsDMM+/8eTZRgXbMsmpK3/ogaR2hz8IVFkmJDRC9ksasvNQNee9WgaG7oB/VqLPlCBMedML8Njshx2gHYmbhwdzZmkpLUwzY6b7YHGpNqqrI5AseQqwpcTy6EUq2UjfnQTG+K4UbzFN2ou1YlrxdwdHw4DeIfYtlt7WuKovdXmrC71KSRTeWm4iA6kPgLAfjKkbLo6fXwTr2A5bU0KsSmnZlBO7v0DYKd2HJnbXEDuAXQ77qUrT4P5jZQUc57IBZ+l6u4O7SbKCCLqpJg6A57/P9ixXjU9PVNmBBlNr+Ug05rN3hxfSEOH+QXmswLVs6ItpF1vksnni1gpBi+7Ii4hOzFc6viKul3mMCLqGHkS5FA+0Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc0dda0-66ba-48a8-65cb-08d86f234f6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 02:54:31.8213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4O0jKRt90l3bbXmHCtczY58mhzpw8PO4K5/XMVlQRGmdZZt/Kx8YgaOLNsFto51LxKCk79D6egwpr8fhOlPJWQNsn++SwbbYXeN63GztOsXX+EdSPjn9iOUqqHI3PglV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3017
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

-----Original Message-----
From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>=20
Sent: Tuesday, 13 October, 2020 2:31 AM
Subject: Re: [PATCH v10 1/2] pwm: Add PWM driver for Intel Keem Bay

Hello Ayyathurai,

you're quoting style is strange. I fixed it up and hope I got it right.

On Mon, Oct 12, 2020 at 08:04:47PM +0000, Ayyathurai, Vijayakannan wrote:
> > On Thu, Oct 08, 2020 at 01:40:30AM +0800, vijayakannan.ayyathurai@intel=
.com wrote:
> > > +static int keembay_pwm_apply(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> > > +			     const struct pwm_state *state) {
> > > +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> > > +	struct pwm_state current_state;
> > > +	u16 pwm_h_count, pwm_l_count;
> > > +	unsigned long long div;
> > > +	unsigned long clk_rate;
> > > +	u32 pwm_count =3D 0;
> > > +
> > > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > > +		return -ENOSYS;
> > > +
> > > +	keembay_pwm_update_bits(priv, KMB_PWM_LEADIN_MASK, 0,
> > > +				KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));
> > > +
> > > +	keembay_pwm_get_state(chip, pwm, &current_state);
> > > +
> > > +	if (!state->enabled) {
> > > +		if (current_state.enabled)
> > > +			keembay_pwm_disable(priv, pwm->hwpwm);
> > > +		return 0;
> > > +	}
> > > +
> > > +	/*
> > > +	 * The upper 16 bits of the KMB_PWM_HIGHLOW_OFFSET register contain
> > > +	 * the high time of the waveform, while the last 16 bits contain
> > > +	 * the low time of the waveform, in terms of clock cycles.
> > > +	 *
> > > +	 * high time =3D clock rate * duty cycle
> > > +	 * low time =3D  clock rate * (period - duty cycle)
> > > +	 */
> > > +
> > > +	clk_rate =3D clk_get_rate(priv->clk);
> > > +	/* Configure waveform high time */
> > > +	div =3D clk_rate * state->duty_cycle;
> > > +	div =3D DIV_ROUND_DOWN_ULL(div, NSEC_PER_SEC);
> > > +	if (div > KMB_PWM_COUNT_MAX)
> > > +		return -ERANGE;
> > > +
> > > +	pwm_h_count =3D div;
> > > +	/* Configure waveform low time */
> > > +	div =3D clk_rate * (state->period - state->duty_cycle);
> > > +	div =3D DIV_ROUND_DOWN_ULL(div, NSEC_PER_SEC - pwm_h_count);
> >=20
> > In reply to your v7 I suggested the example:
> >=20
> > 	clk_rate =3D 333334 [Hz]
> > 	state.duty_cycle =3D 1000500 [ns]
> > 	state.period =3D 2001000 [ns]
> >=20
> > where the expected outcome is
> >=20
> > 	pwm_h_count =3D 333
> > 	pwm_l_count =3D 334
> >=20
> > . Please reread my feedback there. I tried to construct an example=20
> > where the value is more wrong, but with the constraint that=20
> > pwm_h_count must be <=3D KMB_PWM_COUNT_MAX this isn't easy. The best I=
=20
> > could come up with is:
> >=20
> > 	clk_rate =3D 1000000000
> > 	state.duty_cycle =3D 65535 [ns]
> > 	state.period =3D 131070 [ns]
> >=20
> > where the right value for pwm_l_count is 65535 while you calculate
> > 65539 (and then quit with -ERANGE).
>
> I have applied the formula mentioned in v7 and got different duty=20
> cycle result then what was expected.
>=20
> Formula referred by Uwe at v7:
> pwm_l_count =3D (clk_rate * state->period) / NSEC_PER_SEC - pwm_h_count
>=20
> %     clk_rate        period          duty_cycle      NSEC_PER_SEC    pwm=
_h_count             pwm_l_count
> 50%   333334          2001000         1000500         1000000000      333=
                     667
> 25%   500000000       20000           5000            1000000000      250=
0                    10000
> 50%   100000000       131070          65535           1000000000      655=
3                    13107

For the first line:

        (clk_rate * state->period) // NSEC_PER_SEC - pwm_h_count =3D
        (333334 * 2001000) // 1000000000 - 333 =3D
        667.001334 - 333 =3D
        334

This gives duty cycle =3D 333 * 1000000000 / 333334 =3D 998998.0020039959 n=
s and a period =3D (333 + 334) * 1000000000 / 333334 =3D 2000995.998008004 =
ns which is well in the limits.

Thank you for this clarification and I am clear in incorporating it in my n=
ext version. Is there any other feedback in this version v10?

I guess you assumed my formula to be
(clk_rate * state->period) / (NSEC_PER_SEC - pwm_h_count), but that's not w=
hat I meant.

> Whereas the below table is the result of minor modification from your for=
mula and getting the right result.
> pwm_l_count =3D clk_rate * (state->period - state->duty_cycle) /=20
> NSEC_PER_SEC - pwm_h_count
>=20
> %     clk_rate        period          duty_cycle      NSEC_PER_SEC    pwm=
_h_count             pwm_l_count
> 50%   333334          2001000         1000500         1000000000      333=
                     333
> 25%   500000000       20000           5000            1000000000      250=
0                    7500
> 50%   100000000       131070          65535           1000000000      655=
3                    6553
>=20
> Please review this and confirm.

In the code you used

        clk_rate * (state->period - state->duty_cycle) / (NSEC_PER_SEC - pw=
m_h_count)

which is notably different. For the example in the first line again you the=
n get 333, which is a less optimal result than 334 I get with my
(fixed) formula. I'm still convinced my formula is the right and optimal on=
e.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            =
|
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

Thanks,
Vijay

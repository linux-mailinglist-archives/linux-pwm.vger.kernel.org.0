Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C047ED649
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2019 23:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfKCWlo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 3 Nov 2019 17:41:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55145 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfKCWlo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 3 Nov 2019 17:41:44 -0500
Received: by mail-wm1-f68.google.com with SMTP id z26so1520964wmi.4;
        Sun, 03 Nov 2019 14:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HucD2g+iFY7eRxKaYG+od4LZ3/It4oehK1OgkAW2Ebg=;
        b=otjkL/ALDBy2mJUdrrWFPnq2yf3HqrRGFDZE80/A8COATIC9Hc6JNFMRGgABBxOVAY
         P7RPsU30qmVptlpHZ+zLTWSe/vjyrTqJpw+tMt8LcWdzHz4qBAPwkWcePBzVCzTjzsEF
         OVIib/9Y5u7HBVgU1bZHNu52yPzhxSb+lDEMeHssv36yl/KJGMoxC57LQCrpM8q43qv6
         AeyTGh92EvqjtIi4Y2uNN2RJVIJjRvkbFWgK9e1mBbg4pkjmLXEs31mHXrAUztA1SJwE
         3oQ/KVwrOegtFu6EHPvLRNma05r0u8ht/ICBPzE7RawXhLC0M1rp8payzY6fzvv5v8Y5
         6nYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HucD2g+iFY7eRxKaYG+od4LZ3/It4oehK1OgkAW2Ebg=;
        b=TDXiWxJo3qt9Z4UMN2rDBUEH8m72t4YqMYzFaP4TxEKfJ3d6j/kObRRXKDfcL64rki
         6NvY68g8QR162Ija3UzG4Nm7QyitywQ5xl743EZs2XGgS2P7aOl9Z/pOt8GeSWNC8eSF
         pjOKQmLQMj7EWdTYrWN/JP3Ztqav2Ou6fCjv4Scf8elnq8pSK2UpGeYV65OQVXLDKDSi
         wTIlVHk5vGkfAhXIWz603tEnghxjM5uNGefTr9A73d1sqRIGlpE11ugxqm76y5ffeJtc
         Qmswy8JQ4e0HBCVRuVP0AOD7WlNHs0L2XLkbRpzYDh9nC/3cQkj/LJbzMqSEKPf3DW27
         XOfQ==
X-Gm-Message-State: APjAAAXQC36M9oCLTx+a1k7ZlziwXRX7anwLmgNg7cfiFae/PM/3nr4U
        rVhApaUn1+K9WtHIXHCQGudIABi/UALVbMQz7CI=
X-Google-Smtp-Source: APXvYqyPEG01MLTsUGrMY+CVoElO++aDFQdqiZWzgRrFyzj2FCjI2etJek/jIGaF5IazlkvECznyA2C6wFfHjsHLshs=
X-Received: by 2002:a1c:a512:: with SMTP id o18mr19098688wme.4.1572820900868;
 Sun, 03 Nov 2019 14:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20191103203334.10539-5-peron.clem@gmail.com> <201911040602.AEBKHjBk%lkp@intel.com>
In-Reply-To: <201911040602.AEBKHjBk%lkp@intel.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 3 Nov 2019 23:41:29 +0100
Message-ID: <CAJiuCcd-uBAuCNk36iRKNP9F7162tZScWX2aPDVxyYiHMuo1Fw@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] pwm: sun4i: Add support to output source clock directly
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Sun, 3 Nov 2019 at 23:30, kbuild test robot <lkp@intel.com> wrote:
>
> Hi "Cl=C3=A9ment,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on sunxi/sunxi/for-next]
> [also build test ERROR on v5.4-rc5 next-20191031]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system. BTW, we also suggest to use '--base' option to specif=
y the
> base tree in git format-patch, please see https://stackoverflow.com/a/374=
06982]
>
> url:    https://github.com/0day-ci/linux/commits/Cl-ment-P-ron/Add-suppor=
t-for-H6-PWM/20191104-043621
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git s=
unxi/for-next
> config: riscv-allmodconfig (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=3D7.4.0 make.cross ARCH=3Driscv
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers//pwm/pwm-sun4i.c: In function 'sun4i_pwm_get_state':
> >> drivers//pwm/pwm-sun4i.c:132:6: error: 'data' undeclared (first use in=
 this function)
>          data->has_direct_mod_clk_output) {
>          ^~~~

Arg, bad last minute indent fix :
This should be "sun4i_pwm->data->has_direct_mod_clk_output"

Sorry for that,
Cl=C3=A9ment

>    drivers//pwm/pwm-sun4i.c:132:6: note: each undeclared identifier is re=
ported only once for each function it appears in
>
> vim +/data +132 drivers//pwm/pwm-sun4i.c
>
>    112
>    113  static void sun4i_pwm_get_state(struct pwm_chip *chip,
>    114                                  struct pwm_device *pwm,
>    115                                  struct pwm_state *state)
>    116  {
>    117          struct sun4i_pwm_chip *sun4i_pwm =3D to_sun4i_pwm_chip(ch=
ip);
>    118          u64 clk_rate, tmp;
>    119          u32 val;
>    120          unsigned int prescaler;
>    121
>    122          clk_rate =3D clk_get_rate(sun4i_pwm->clk);
>    123
>    124          val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
>    125
>    126          /*
>    127           * PWM chapter in H6 manual has a diagram which explains =
that if bypass
>    128           * bit is set, no other setting has any meaning. Even mor=
e, experiment
>    129           * proved that also enable bit is ignored in this case.
>    130           */
>    131          if ((val & BIT_CH(PWM_BYPASS, pwm->hwpwm)) &&
>  > 132              data->has_direct_mod_clk_output) {
>    133                  state->period =3D DIV_ROUND_CLOSEST_ULL(NSEC_PER_=
SEC, clk_rate);
>    134                  state->duty_cycle =3D state->period / 2;
>    135                  state->polarity =3D PWM_POLARITY_NORMAL;
>    136                  state->enabled =3D true;
>    137                  return;
>    138          }
>    139
>    140          if ((PWM_REG_PRESCAL(val, pwm->hwpwm) =3D=3D PWM_PRESCAL_=
MASK) &&
>    141              sun4i_pwm->data->has_prescaler_bypass)
>    142                  prescaler =3D 1;
>    143          else
>    144                  prescaler =3D prescaler_table[PWM_REG_PRESCAL(val=
, pwm->hwpwm)];
>    145
>    146          if (prescaler =3D=3D 0)
>    147                  return;
>    148
>    149          if (val & BIT_CH(PWM_ACT_STATE, pwm->hwpwm))
>    150                  state->polarity =3D PWM_POLARITY_NORMAL;
>    151          else
>    152                  state->polarity =3D PWM_POLARITY_INVERSED;
>    153
>    154          if ((val & BIT_CH(PWM_CLK_GATING | PWM_EN, pwm->hwpwm)) =
=3D=3D
>    155              BIT_CH(PWM_CLK_GATING | PWM_EN, pwm->hwpwm))
>    156                  state->enabled =3D true;
>    157          else
>    158                  state->enabled =3D false;
>    159
>    160          val =3D sun4i_pwm_readl(sun4i_pwm, PWM_CH_PRD(pwm->hwpwm)=
);
>    161
>    162          tmp =3D prescaler * NSEC_PER_SEC * PWM_REG_DTY(val);
>    163          state->duty_cycle =3D DIV_ROUND_CLOSEST_ULL(tmp, clk_rate=
);
>    164
>    165          tmp =3D prescaler * NSEC_PER_SEC * PWM_REG_PRD(val);
>    166          state->period =3D DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
>    167  }
>    168
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion

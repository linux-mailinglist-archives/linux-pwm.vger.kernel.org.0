Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B3922FACB
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 22:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgG0U5L (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 16:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgG0U5K (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 16:57:10 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA89C061794;
        Mon, 27 Jul 2020 13:57:10 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dk23so6585521ejb.11;
        Mon, 27 Jul 2020 13:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+WXybRNIUsUWOZ+JzhFF8n0Y/tkCcTOibeRYqQZPjfs=;
        b=hPcwslpF0T31laTII1OdphFHnPEn/+kyFmyO69Y0AwMqnlRnIsfnRxUPtlvM5BkQw9
         swmq7YN6zCBNd+OgstVnQa8NoDRjU/Z4LCmQ8bCjM8l856IFZ1ZdpIbSfH1Cu/wh5jaU
         ynPqz1YdEAgX8U+clSj2hvWozDVoCYKRGyQe1Qqgc48KGVAAOV9z3rA/mYeARPzfWo5H
         GH35msHvO2cY0fbenhyNtXd+Dl+Ovi7/z0Roh/85z65K7vYumhT5TymfPacBkp1r964t
         fdwhARQnm1d5peXud6JR30yNjederSkRVdzAVRSch0bVIXvtrU2I2d7AprkFo6SkkP6M
         4qHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+WXybRNIUsUWOZ+JzhFF8n0Y/tkCcTOibeRYqQZPjfs=;
        b=ZQ5IogwtacPN6WilGs8V6jLnemlsFcEmG7KLhCdZ7eS+n3WokRgaLCPhRnUfCgXeN6
         YNOoW+8+69SEsfF6ysVAT7GLaEcVsX8mxDNQx6pFeVHwA6rb7Wfat5g0l9A8iFQP0H7O
         uSwGQ1mWEVFzfl03xX39EqftDxjrMdcUftsmM3/G1EmRlTh9cMDX7QeLk66UsZF3pfgW
         mzU1Oq6Cg3AS2+JXf20Yq/ftrI6k7Ow4sX2uRAug5V7foIz82jo0Cq4XbLHynp785Oy+
         CJdcNE1a7kfxHmaLJpaLNOnWUuKLvZqOl38Q+9zD/3pbCQN8eMDd/t7FeiMFC78So10x
         En3A==
X-Gm-Message-State: AOAM533fbltZhLeG/F7cz0iCNjR2I8gVaCNJVKFo5T4g1YFdKBIjJW6p
        iuZx9BgkuiZaEQw0K40GxBM3P4jqLFkr1qHzFP8=
X-Google-Smtp-Source: ABdhPJxop/vEgCXatU5dwsU9mctsq4Z4SbyrEeG8T6Gtdoy6PNMtcVi5UKqTMG8vcrUXL53BwtlQuuzn773zX3tSg1M=
X-Received: by 2002:a17:906:1392:: with SMTP id f18mr14718052ejc.521.1595883429069;
 Mon, 27 Jul 2020 13:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200724213659.273599-1-martin.botka1@gmail.com>
 <20200724213659.273599-2-martin.botka1@gmail.com> <20200727201034.dkc6qkkbte6qeiba@pengutronix.de>
In-Reply-To: <20200727201034.dkc6qkkbte6qeiba@pengutronix.de>
From:   Martin Botka <martin.botka1@gmail.com>
Date:   Mon, 27 Jul 2020 22:56:31 +0200
Message-ID: <CADQ2G_GxpWk1AK4OQPZZuk=vCmostC4vEGSHjj01WMzFxpD7CA@mail.gmail.com>
Subject: Re: [PATCH RCC 1/6] pwm: Add different PWM output types support
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Mo 27. 7. 2020 at 22:10 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.=
de> wrote:
>
> Hello,
>
> On Fri, Jul 24, 2020 at 11:36:51PM +0200, Martin Botka wrote:
> > From: Fenglin Wu <fenglinw@codeaurora.org>
> >
> > Normally, PWM channel has fixed output until software request to change
>
> "fixed" in the sense of "periodic", not "constant", right?

Correct.

>
> > its settings. There are some PWM devices which their outputs could be
> > changed autonomously according to a predefined pattern programmed in
> > hardware. Add pwm_output_type enum type to identify these two different
> > PWM types and add relevant helper functions to set and get PWM output
> > types and pattern.
>
> You write "some devices". Which do you have in mind?

As can be seen this commit is not authored by me so the commit message
is from the original author.
So i don't know what the original author meant here.
I can only guess that s/he meant all the PWM chips made by Qcom or
other companies that also have hardware based support for patterns.

>
> > [...]
> > diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> > index 2389b8669846..4ee1e81db0bc 100644
> > --- a/drivers/pwm/sysfs.c
> > +++ b/drivers/pwm/sysfs.c
>
> adapting the sysfs stuff should be done in a separate step.

By that you mean in separate commit right ?

>
> > @@ -215,11 +215,60 @@ static ssize_t capture_show(struct device *child,
> >       return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
> >  }
> >
> > +static ssize_t output_type_show(struct device *child,
> > +                                                     struct device_att=
ribute *attr,
> > +                                                     char *buf)
> > +{
> > +     const struct pwm_device *pwm =3D child_to_pwm_device(child);
> > +     const char *output_type =3D "unknown";
> > +     struct pwm_state state;
> > +
> > +     pwm_get_state(pwm, &state);
> > +     switch (state.output_type) {
> > +     case PWM_OUTPUT_FIXED:
> > +             output_type =3D "fixed";
> > +             break;
> > +     case PWM_OUTPUT_MODULATED:
> > +             output_type =3D "modulated";
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return snprintf(buf, PAGE_SIZE, "%s\n", output_type);
> > +}
> > +
> > +static ssize_t output_type_store(struct device *child,
> > +                                                             struct de=
vice_attribute *attr,
> > +                                                             const cha=
r *buf, size_t size)
>
> Indention is broken here. Please align to the opening (.

OK. Will do.

>
> > +{
> > +     struct pwm_export *export =3D child_to_pwm_export(child);
> > +     struct pwm_device *pwm =3D export->pwm;
> > +     struct pwm_state state;
> > +     int ret =3D -EINVAL;
> > +
> > +     mutex_lock(&export->lock);
> > +     pwm_get_state(pwm, &state);
> > +     if (sysfs_streq(buf, "fixed"))
> > +             state.output_type =3D PWM_OUTPUT_FIXED;
> > +     else if (sysfs_streq(buf, "modulated"))
> > +             state.output_type =3D PWM_OUTPUT_MODULATED;
> > +     else
> > +             goto unlock;
> > +
> > +     ret =3D pwm_apply_state(pwm, &state);
> > +unlock:
> > +     mutex_unlock(&export->lock);
> > +
> > +     return ret ? : size;
> > +}
> > +
> >  static DEVICE_ATTR_RW(period);
> >  static DEVICE_ATTR_RW(duty_cycle);
> >  static DEVICE_ATTR_RW(enable);
> >  static DEVICE_ATTR_RW(polarity);
> >  static DEVICE_ATTR_RO(capture);
> > +static DEVICE_ATTR_RW(output_type);
> >
> >  static struct attribute *pwm_attrs[] =3D {
> >       &dev_attr_period.attr,
> > @@ -227,6 +276,7 @@ static struct attribute *pwm_attrs[] =3D {
> >       &dev_attr_enable.attr,
> >       &dev_attr_polarity.attr,
> >       &dev_attr_capture.attr,
> > +     &dev_attr_output_type.attr,
> >       NULL
> >  };
> >  ATTRIBUTE_GROUPS(pwm);
> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > index 2635b2a55090..10a102efadc4 100644
> > --- a/include/linux/pwm.h
> > +++ b/include/linux/pwm.h
> > @@ -48,6 +48,29 @@ enum {
> >       PWMF_EXPORTED =3D 1 << 1,
> >  };
> >
> > +/*
> > + * enum pwm_output_type - output type of the PWM signal
> > + * @PWM_OUTPUT_FIXED: PWM output is fixed until a change request
> > + * @PWM_OUTPUT_MODULATED: PWM output is modulated in hardware
> > + * autonomously with a predefined pattern
> > + */
> > +enum pwm_output_type {
> > +     PWM_OUTPUT_FIXED =3D 1 << 0,
> > +     PWM_OUTPUT_MODULATED =3D 1 << 1,
> > +};
> > +
> > +/*
> > + * struct pwm_output_pattern - PWM duty pattern for MODULATED duty typ=
e
> > + * @duty_pattern: PWM duty cycles in the pattern for duty modulation
> > + * @num_entries: number of entries in the pattern
> > + * @cycles_per_duty: number of PWM period cycles an entry stays at
> > + */
> > +struct pwm_output_pattern {
> > +     unsigned int *duty_pattern;
> > +     unsigned int num_entries;
> > +     unsigned int cycles_per_duty;
> > +};
>
> I don't understand the semantics here. (i.e. how does a given
> pwm_output_pattern map to the intended wave form?)

I did not understand that part either.
It's not uncommon for Qcom to have some stuff hidden like this in
other drivers that we have in downstream (Tho they mainly hide that in
pre-compiled binary blobs).
Here it's either the missing PBS driver from downstream that i want to
send later in separate series.
Or that it's fully done in hardware. Unlikely but you never know with Qcom.


>
> > +
> >  /*
> >   * struct pwm_state - state of a PWM channel
> >   * @period: PWM period (in nanoseconds)
> > @@ -59,6 +82,8 @@ struct pwm_state {
> >       unsigned int period;
> >       unsigned int duty_cycle;
> >       enum pwm_polarity polarity;
> > +     enum pwm_output_type output_type;
> > +     struct pwm_output_pattern *output_pattern;
> >       bool enabled;
> >  };
> >
> > @@ -146,6 +171,26 @@ static inline enum pwm_polarity pwm_get_polarity(c=
onst struct pwm_device *pwm)
> >       return state.polarity;
> >  }
> >
> > +static inline enum pwm_output_type pwm_get_output_type(
> > +                             const struct pwm_device *pwm)
> > +{
> > +     struct pwm_state state;
> > +
> > +     pwm_get_state(pwm, &state);
> > +
> > +     return state.output_type;
> > +}
> > +
> > +static inline struct pwm_output_pattern *pwm_get_output_pattern(
> > +                             struct pwm_device *pwm)
> > +{
> > +     struct pwm_state state;
> > +
> > +     pwm_get_state(pwm, &state);
> > +
> > +     return pwm->state.output_pattern ?: NULL;
>
> Who is the owner of the data behind this pointer? Is it expected to be
> valid only until the next call to change the output? What happens if the
> caller modifies the data returned?
>
> > +}
> > +
> >  static inline void pwm_get_args(const struct pwm_device *pwm,
> >                               struct pwm_args *args)
> >  {
> > @@ -254,6 +299,9 @@ pwm_set_relative_duty_cycle(struct pwm_state *state=
, unsigned int duty_cycle,
> >   * @set_polarity: configure the polarity of this PWM
> >   * @enable: enable PWM output toggling
> >   * @disable: disable PWM output toggling
> > + * @get_output_type_supported: get the supported output type
> > + * @set_output_type: set PWM output type
> > + * @set_output_pattern: set the pattern for the modulated output
> >   */
> >  struct pwm_ops {
> >       int (*request)(struct pwm_chip *chip, struct pwm_device *pwm);
> > @@ -273,6 +321,13 @@ struct pwm_ops {
> >                           enum pwm_polarity polarity);
> >       int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
> >       void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
> > +     int (*get_output_type_supported)(struct pwm_chip *chip,
> > +                         struct pwm_device *pwm);
> > +     int (*set_output_type)(struct pwm_chip *chip, struct pwm_device *=
pwm,
> > +                         enum pwm_output_type output_type);
> > +     int (*set_output_pattern)(struct pwm_chip *chip,
> > +                         struct pwm_device *pwm,
> > +                         struct pwm_output_pattern *output_pattern);
>
> This doesn't match the atomic approach that we're following since the
> introduction of .apply. Please don't add new non-atomic callbacks.
>
> >  };
> >
> >  /**
> > @@ -318,6 +373,20 @@ void pwm_free(struct pwm_device *pwm);
> >  int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *st=
ate);
> >  int pwm_adjust_config(struct pwm_device *pwm);
> >
> > +/*
> > + * pwm_output_type_support()
> > + * @pwm: PWM device
> > + *
> > + * Returns:  output types supported by the PWM device
> > + */
> > +static inline int pwm_get_output_type_supported(struct pwm_device *pwm=
)
> > +{
> > +     if (pwm->chip->ops->get_output_type_supported !=3D NULL)
> > +             return pwm->chip->ops->get_output_type_supported(pwm->chi=
p, pwm);
> > +     else
> > +             return PWM_OUTPUT_FIXED;
> > +}
>
> I don't like this "advertising" for specific functions. I'd prefer to
> handle this in .apply(), fix all drivers to return -ESOMETHING when the
> request cannot be fulfilled.

I will have to disagree on this one. As the functions are called in
multiple places it would just make mess in the driver.
As the driver is even now not exactly the definition of clean driver i
would not like to make it even more messy.

>
> Having said that I wonder if this output pattern is a common enough
> property to add support for it in the PWM framework.
>

I have gotten an email from Guru Das Srinagesh regarding this exact
issue you are pointing to. Yes the output pattern will be dropped in
V2.

Best Regards,
Martin

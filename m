Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76E4E150FBF
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Feb 2020 19:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgBCSjv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Feb 2020 13:39:51 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:40574 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbgBCSjv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Feb 2020 13:39:51 -0500
Received: by mail-qv1-f67.google.com with SMTP id dp13so7293189qvb.7
        for <linux-pwm@vger.kernel.org>; Mon, 03 Feb 2020 10:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Il6XQshJNFTKlxloPo0tHXa6dTM59eOI4JIxahczn70=;
        b=fYK35UF7/KEcKhM5B4Hkw/zN/WXIYaZqGxwqBK/iS7bjlJiLmajAQUzLZXzqvNNkjy
         C13unCflsld/wlRseCalRIdk2lccNINvEIOSo/ZxoldppPxEen1UeNDVanFO/rPyCdCA
         sL/idk8kSK3NrPmk9pFWtvF9d4GAIXbXTTgSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Il6XQshJNFTKlxloPo0tHXa6dTM59eOI4JIxahczn70=;
        b=kIJZIODx5oFX8HcXfB7C8C3VMJ/81WZZHK1IJaVmltTvgNtYkYN2c1LgUDpOysY885
         fIjfvoE6pHB/LreJK/CqroOmHRSp15TQRb0wjQv+/Ox+3BqhivKmDspFHt7C/e/Y3/gM
         wqjKwvD7u1nyYlAzYBoivDMlkXlxH7zKHllR9NZ3cpIkrcf+9yynfGLs26/MKuxBSkmk
         SMlPEK2Aj4ATorJO/yXOdPSpIKAkW15/CLBgxpsoT+zMmA9jgG3PG2fxOUQ66kgNqmMa
         l19G6gRzRi27LesJ80Y6bjF1S1WQ1UJMFXcIKffS6U7I1Cd0RcrJtF9Nb1p2/rIRj/Xx
         zwNw==
X-Gm-Message-State: APjAAAUY+hw2Nh4twtFq9MsEYtvoLxY0uROAoytHAER3tP4WbYaANvef
        vGAfJI2FAZcG3E+d26YAjmsHvwOisg0jqmJtKVznEA==
X-Google-Smtp-Source: APXvYqz6yocBMBK3Xc21RoO3O8L8ZLpDlqlI+TYq5Z+1/Ua4Qk8gmtMFurGcFBVzfbYKb5cjpa1QA6F4wMPrfDAIw9Q=
X-Received: by 2002:a0c:e790:: with SMTP id x16mr23571260qvn.18.1580755190178;
 Mon, 03 Feb 2020 10:39:50 -0800 (PST)
MIME-Version: 1.0
References: <20200130203106.201894-1-pmalani@chromium.org> <20200130203106.201894-14-pmalani@chromium.org>
 <5d7cbb93-dfa0-11d3-1374-2e4044ead524@collabora.com> <CACeCKac=WyYZqnP=OqG9CoMWUfJzE=RwE+CtXhAbu7G5gmBfCA@mail.gmail.com>
In-Reply-To: <CACeCKac=WyYZqnP=OqG9CoMWUfJzE=RwE+CtXhAbu7G5gmBfCA@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 3 Feb 2020 10:39:39 -0800
Message-ID: <CACeCKacLSYF_MWqTxidQW5m__vDXSnPVgKttLcLU4X_4xfrJAQ@mail.gmail.com>
Subject: Re: [PATCH 13/17] pwm: cros-ec: Remove cros_ec_cmd_xfer_status()
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Enric,

On Mon, Feb 3, 2020 at 10:26 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> On Mon, Feb 3, 2020 at 7:33 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> >
> > On 30/1/20 21:31, Prashant Malani wrote:
> > > Convert one existing usage of cros_ec_cmd_xfer_status() to
> > > cros_ec_send_cmd_msg(), which accomplishes the same thing but also does
> > > the EC message struct setup,and is defined in platform/chrome and is
> > > accessible by other modules.
> > >
> > > For the other usage, switch it to using cros_ec_cmd_xfer(), since the
> > > calling functions rely on the result field of the struct cros_ec_command
> > > struct that is used.
> > >
> > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > ---
> > >  drivers/pwm/pwm-cros-ec.c | 27 +++++++++------------------
> > >  1 file changed, 9 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> > > index 89497448d21775..8bf610a6529e7e 100644
> > > --- a/drivers/pwm/pwm-cros-ec.c
> > > +++ b/drivers/pwm/pwm-cros-ec.c
> > > @@ -32,25 +32,14 @@ static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *c)
> > >
> > >  static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
> > >  {
> > > -     struct {
> > > -             struct cros_ec_command msg;
> > > -             struct ec_params_pwm_set_duty params;
> > > -     } __packed buf;
> > > -     struct ec_params_pwm_set_duty *params = &buf.params;
> > > -     struct cros_ec_command *msg = &buf.msg;
> > > -
> > > -     memset(&buf, 0, sizeof(buf));
> > > +     struct ec_params_pwm_set_duty params = {0};
> > >
> > > -     msg->version = 0;
> > > -     msg->command = EC_CMD_PWM_SET_DUTY;
> > > -     msg->insize = 0;
> > > -     msg->outsize = sizeof(*params);
> > > -
> > > -     params->duty = duty;
> > > -     params->pwm_type = EC_PWM_TYPE_GENERIC;
> > > -     params->index = index;
> > > +     params.duty = duty;
> > > +     params.pwm_type = EC_PWM_TYPE_GENERIC;
> > > +     params.index = index;
> > >
> > > -     return cros_ec_cmd_xfer_status(ec, msg);
> > > +     return cros_ec_send_cmd_msg(ec, 0, EC_CMD_PWM_SET_DUTY, &params,
> > > +                                 sizeof(params), NULL, 0);
> > >  }
> > >
> > >  static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
> > > @@ -78,11 +67,13 @@ static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
> > >       params->pwm_type = EC_PWM_TYPE_GENERIC;
> > >       params->index = index;
> > >
> > > -     ret = cros_ec_cmd_xfer_status(ec, msg);
> > > +     ret = cros_ec_cmd_xfer(ec, msg);
> >
> > Why? There is a good reason we introduced the cros_ec_cmd_xfer_status.
> >
> > IMO the purpose of introduce the new wrapper only makes sense if we can cover
> > _all_ the cases, so we can remove cros_ec_cmd_xfer_status and make
> > cros_ec_cmd_xfer private to cros_ec_proto.
I'm hoping for that too, but as we saw below (and some in some other
drivers), some callers of cros_ec_cmd_xfer() actually use the
msg->result.
Should we change the new wrapper to return the message via a pointer
(if not NULL), so something like this ? :

int cros_ec_send_cmd_msg(struct cros_ec_device *ec, unsigned int
version, uint32_t command, void *outdata, unsigned int outsize,
void *indata, unsigned int insize, uint32_t *result) ?

> >
> > Is not possible to use the new wrapper here?
> >
> > >       if (result)
> > >               *result = msg->result;
> >
> > Hmm, I see, that's the problem ...
> >
> > This driver will need a bit of rework but I think could be possible to use the
> > wrapper.
> Yeah, I looked around, and it seems to use msg->result.
> Perhaps we should work on reworking this driver before doing the large
> patch series? I would be happy to work on it, unless you feel there is
> someone else who'd be better suited. Kindly let me know.
> >
> > >       if (ret < 0)
> > >               return ret;
> > > +     else if (msg->result != EC_RES_SUCCESS)
> > > +             return -EPROTO;
> > >
> > >       return resp->duty;
> > >  }
> > >

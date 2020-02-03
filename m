Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7169C150F50
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Feb 2020 19:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgBCS0f (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Feb 2020 13:26:35 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45726 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728435AbgBCS0f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Feb 2020 13:26:35 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so15182750qkl.12
        for <linux-pwm@vger.kernel.org>; Mon, 03 Feb 2020 10:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BELLzTXfYdXeL9jGMOaTmw4FiGkMz9yBmaZNMeT+PRA=;
        b=Jy9OC9jIwZN+3jqZrWcW8kTai/WdwOXHf/gNkqaSyXl/Y9/4q2gTCQGZww3Y52E6/s
         jq/EgSmXB/d+97Wn5LHPNdiJutdiPBqv5t+wS5tolWn126kvJCYlFYaNc51qUdLhMnLe
         7aba25ZPTc4pHsvE2qkyjMlg31ResphNVxR2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BELLzTXfYdXeL9jGMOaTmw4FiGkMz9yBmaZNMeT+PRA=;
        b=JDAf+TpojpmRzDWTp0KbXOd5QwSD7/nlt70E4LC3KY6c2SmT3kIGQiYdriC5ric/dY
         qqjU67HSRbFNY3PveQUHAvHYhtOSbukw1nMWnkM1kPC/nujvX6tbWkhz1uyfoQEwg94O
         R73Ic4tn825DrCcF/mnBMV+w8XcHATjKp4x3HgZI2oKx/8IFowV4krS6tmETDn9d5wXO
         W7gA3NTwAoo8S9GvGAoS1hTx2twZeItuYWiz1W5bCESy5bMLq3C2TUok7xBwdEpfnm0Z
         1rpRr7CoJv29aYH1lxmRofjbcyFe6xV9zV+0I2XsXu/fyPyIacoo4U5IlOvvKOqNqEMx
         QrNg==
X-Gm-Message-State: APjAAAUIy87rbwoPoNICAOY6Z3j8QHBh/Wi+ZECMLzrwB6hfYAmu0LVd
        nlQIgCV8v6AC5PyxbnjOIWhyDByHkL66Uth3VCj2kw==
X-Google-Smtp-Source: APXvYqyTq7y7Gbct+90qnHqinJc7Xple1PAWjx5QzsYlhwdd+4bRoTpe23xSKg7Ahw1ndrLiELlYE3aeZDPJIe0upyw=
X-Received: by 2002:a37:6c6:: with SMTP id 189mr23705506qkg.179.1580754394072;
 Mon, 03 Feb 2020 10:26:34 -0800 (PST)
MIME-Version: 1.0
References: <20200130203106.201894-1-pmalani@chromium.org> <20200130203106.201894-14-pmalani@chromium.org>
 <5d7cbb93-dfa0-11d3-1374-2e4044ead524@collabora.com>
In-Reply-To: <5d7cbb93-dfa0-11d3-1374-2e4044ead524@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 3 Feb 2020 10:26:23 -0800
Message-ID: <CACeCKac=WyYZqnP=OqG9CoMWUfJzE=RwE+CtXhAbu7G5gmBfCA@mail.gmail.com>
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

On Mon, Feb 3, 2020 at 7:33 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
>
> On 30/1/20 21:31, Prashant Malani wrote:
> > Convert one existing usage of cros_ec_cmd_xfer_status() to
> > cros_ec_send_cmd_msg(), which accomplishes the same thing but also does
> > the EC message struct setup,and is defined in platform/chrome and is
> > accessible by other modules.
> >
> > For the other usage, switch it to using cros_ec_cmd_xfer(), since the
> > calling functions rely on the result field of the struct cros_ec_command
> > struct that is used.
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/pwm/pwm-cros-ec.c | 27 +++++++++------------------
> >  1 file changed, 9 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> > index 89497448d21775..8bf610a6529e7e 100644
> > --- a/drivers/pwm/pwm-cros-ec.c
> > +++ b/drivers/pwm/pwm-cros-ec.c
> > @@ -32,25 +32,14 @@ static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *c)
> >
> >  static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
> >  {
> > -     struct {
> > -             struct cros_ec_command msg;
> > -             struct ec_params_pwm_set_duty params;
> > -     } __packed buf;
> > -     struct ec_params_pwm_set_duty *params = &buf.params;
> > -     struct cros_ec_command *msg = &buf.msg;
> > -
> > -     memset(&buf, 0, sizeof(buf));
> > +     struct ec_params_pwm_set_duty params = {0};
> >
> > -     msg->version = 0;
> > -     msg->command = EC_CMD_PWM_SET_DUTY;
> > -     msg->insize = 0;
> > -     msg->outsize = sizeof(*params);
> > -
> > -     params->duty = duty;
> > -     params->pwm_type = EC_PWM_TYPE_GENERIC;
> > -     params->index = index;
> > +     params.duty = duty;
> > +     params.pwm_type = EC_PWM_TYPE_GENERIC;
> > +     params.index = index;
> >
> > -     return cros_ec_cmd_xfer_status(ec, msg);
> > +     return cros_ec_send_cmd_msg(ec, 0, EC_CMD_PWM_SET_DUTY, &params,
> > +                                 sizeof(params), NULL, 0);
> >  }
> >
> >  static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
> > @@ -78,11 +67,13 @@ static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
> >       params->pwm_type = EC_PWM_TYPE_GENERIC;
> >       params->index = index;
> >
> > -     ret = cros_ec_cmd_xfer_status(ec, msg);
> > +     ret = cros_ec_cmd_xfer(ec, msg);
>
> Why? There is a good reason we introduced the cros_ec_cmd_xfer_status.
>
> IMO the purpose of introduce the new wrapper only makes sense if we can cover
> _all_ the cases, so we can remove cros_ec_cmd_xfer_status and make
> cros_ec_cmd_xfer private to cros_ec_proto.
>
> Is not possible to use the new wrapper here?
>
> >       if (result)
> >               *result = msg->result;
>
> Hmm, I see, that's the problem ...
>
> This driver will need a bit of rework but I think could be possible to use the
> wrapper.
Yeah, I looked around, and it seems to use msg->result.
Perhaps we should work on reworking this driver before doing the large
patch series? I would be happy to work on it, unless you feel there is
someone else who'd be better suited. Kindly let me know.
>
> >       if (ret < 0)
> >               return ret;
> > +     else if (msg->result != EC_RES_SUCCESS)
> > +             return -EPROTO;
> >
> >       return resp->duty;
> >  }
> >

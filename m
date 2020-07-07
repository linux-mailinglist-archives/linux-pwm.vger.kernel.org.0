Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2723D21791F
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jul 2020 22:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgGGUQI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Jul 2020 16:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGGUQI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jul 2020 16:16:08 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8B3C061755
        for <linux-pwm@vger.kernel.org>; Tue,  7 Jul 2020 13:16:07 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 5so33267713oty.11
        for <linux-pwm@vger.kernel.org>; Tue, 07 Jul 2020 13:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+22N0fOpcCS5SHpYTI8THu7MMRhiQaejeBMyTlaahU=;
        b=EquUuifwfhsn/ix0vmpEHhAWfsmW4GalHdONr5DM1bS3GG8s73FmBJVOi7ONS0teOA
         fWn/i0UEBW86n3c9iK2FRAydkU4ZbFvDt0vOmKTAeMp8ijQSXZ7vFDbFNohMsiEWsbNF
         w31u2sc9MX8Urpfldbhli3ecRj1Y0U98myQEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+22N0fOpcCS5SHpYTI8THu7MMRhiQaejeBMyTlaahU=;
        b=E2UZM7LzlT3Lg64bFxxaiM7s5PwZuuU79mKGttgRZnZtsJBwCzE7hKoVM0Ce1vWaSD
         WqLBksC0Gl4b7qNlmqhG9t7OT/6n1EvZuG3rhWWTb6rQWF641FnqlO1qKszjJsdGCdZc
         Ys/92qDLFrzs052aVp2seNLrGWAhFNUZNm2mtCxrrBVyVY6z6F7D0QPMb24SD9HSKje9
         DNlha6MbWkmhmp9kh3qjZsBNlQxw3w3QHahLPgfQDn2/V7MnCVLmm5d8SXTpttw5Ru7D
         TcuV8Y6tScFBUrK8EmWDazZgky26nO1MAKsZoAnoQgZv0C3mLf1eS0cvgDJbxAA7kCqa
         63hA==
X-Gm-Message-State: AOAM532cmTEl0yWbVhrCrJXTh4Amx7xbwE1fFNi27Y6mXbEhjJ1V6C+9
        eDE10HJ5CYhtypbu/zjSat0ov4pWYbhNIlEqwculLQ==
X-Google-Smtp-Source: ABdhPJxZo5c6iIUJ30q5a3nuvLIprlOH0NzgEJW0dD3q2qDU+xjWouYsQQ7QkXbQ3RBiEnN104Wzdb7SFXvvZUGZHaI=
X-Received: by 2002:a05:6830:1d0:: with SMTP id r16mr36474224ota.188.1594152967004;
 Tue, 07 Jul 2020 13:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200703184546.144664-1-sam@ravnborg.org> <20200703184546.144664-18-sam@ravnborg.org>
 <20200707054820.GF3278063@phenom.ffwll.local> <20200707195928.GA18394@ravnborg.org>
In-Reply-To: <20200707195928.GA18394@ravnborg.org>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 7 Jul 2020 22:15:55 +0200
Message-ID: <CAKMK7uGAgYNZKRx6h0h1dL=Q8CUbxBkomAb2V=vMenx6VnHzzw@mail.gmail.com>
Subject: Re: [PATCH v4 17/20] backlight: use backligt_get_brightness()
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andy Gross <agross@kernel.org>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jul 7, 2020 at 9:59 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Tue, Jul 07, 2020 at 07:48:20AM +0200, Daniel Vetter wrote:
> > On Fri, Jul 03, 2020 at 08:45:43PM +0200, Sam Ravnborg wrote:
> > > Introduce the backlight_get_brightness() helper in all
> > > video/backlight/* drivers.
> > > This simplifies the code and align the implementation of the
> > > update_status() operation across the different backlight drivers.
> > >
> > > Some of the drivers gains a little extra functionality by the change
> > > as they now respect the fb_blank() ioctl.
> > >
> > > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> >
> > This looks really nice!
> >
> > Since there's a pile more backlight drivers all over the tree, care to
> > update the gpu/todo.rst entry with a note that conversions should use
> > backlight_get_brightness?
>
> When I stop doing backlight stuff I will compose a proper
> todo entry. Right now I hope to get first batch included in upstream.

Sounds all good to me.

> I hope this set can hit upstream.
> Next it to convert backlight stuff in gpu/drm/ - let me see how that
> all turns out. One idea is to support embedding struct backlight_device,
> but I am not sure if this really will fly.

Embedding means you tie the lifetime of the backlight device to the
lifetime of whatever structure it's embedded in. This might be a
complete pain, but it might also work out since backlight
register/unregistering is fairly simple. But I'd be vary, maybe before
we do that we'll need stuff like device_link between backlight and
drm_device (to make sure the drm_device never outlives the backlight
at a device level), and maybe a few other tricks.

Does sound like a lot of head-scratcher fun though to work through all this :-)

Cheers, Daniel

>
>         Sam
>
> > -Daniel
> >
> > > ---
> > >  drivers/video/backlight/88pm860x_bl.c | 13 +------------
> > >  drivers/video/backlight/adp5520_bl.c  | 10 +---------
> > >  drivers/video/backlight/adp8860_bl.c  | 10 +---------
> > >  drivers/video/backlight/adp8870_bl.c  | 10 +---------
> > >  drivers/video/backlight/bd6107.c      |  7 +------
> > >  drivers/video/backlight/corgi_lcd.c   |  8 +-------
> > >  drivers/video/backlight/da903x_bl.c   | 13 +------------
> > >  drivers/video/backlight/ep93xx_bl.c   |  8 +-------
> > >  drivers/video/backlight/hp680_bl.c    |  6 +-----
> > >  drivers/video/backlight/kb3886_bl.c   |  6 +-----
> > >  drivers/video/backlight/led_bl.c      |  7 +------
> > >  drivers/video/backlight/lm3533_bl.c   |  8 +-------
> > >  drivers/video/backlight/locomolcd.c   |  6 +-----
> > >  drivers/video/backlight/lv5207lp.c    |  7 +------
> > >  drivers/video/backlight/max8925_bl.c  | 13 +------------
> > >  drivers/video/backlight/pwm_bl.c      |  7 +------
> > >  drivers/video/backlight/qcom-wled.c   |  7 +------
> > >  drivers/video/backlight/tps65217_bl.c | 10 +---------
> > >  drivers/video/backlight/wm831x_bl.c   | 13 +------------
> > >  19 files changed, 19 insertions(+), 150 deletions(-)
> > >
> > > diff --git a/drivers/video/backlight/88pm860x_bl.c b/drivers/video/backlight/88pm860x_bl.c
> > > index 20d96a5ac384..25e409bbb1a2 100644
> > > --- a/drivers/video/backlight/88pm860x_bl.c
> > > +++ b/drivers/video/backlight/88pm860x_bl.c
> > > @@ -121,18 +121,7 @@ static int pm860x_backlight_set(struct backlight_device *bl, int brightness)
> > >
> > >  static int pm860x_backlight_update_status(struct backlight_device *bl)
> > >  {
> > > -   int brightness = bl->props.brightness;
> > > -
> > > -   if (bl->props.power != FB_BLANK_UNBLANK)
> > > -           brightness = 0;
> > > -
> > > -   if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> > > -           brightness = 0;
> > > -
> > > -   if (bl->props.state & BL_CORE_SUSPENDED)
> > > -           brightness = 0;
> > > -
> > > -   return pm860x_backlight_set(bl, brightness);
> > > +   return pm860x_backlight_set(bl, backlight_get_brightness(bl));
> > >  }
> > >
> > >  static int pm860x_backlight_get_brightness(struct backlight_device *bl)
> > > diff --git a/drivers/video/backlight/adp5520_bl.c b/drivers/video/backlight/adp5520_bl.c
> > > index 0f63f76723a5..686988c3df3a 100644
> > > --- a/drivers/video/backlight/adp5520_bl.c
> > > +++ b/drivers/video/backlight/adp5520_bl.c
> > > @@ -65,15 +65,7 @@ static int adp5520_bl_set(struct backlight_device *bl, int brightness)
> > >
> > >  static int adp5520_bl_update_status(struct backlight_device *bl)
> > >  {
> > > -   int brightness = bl->props.brightness;
> > > -
> > > -   if (bl->props.power != FB_BLANK_UNBLANK)
> > > -           brightness = 0;
> > > -
> > > -   if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> > > -           brightness = 0;
> > > -
> > > -   return adp5520_bl_set(bl, brightness);
> > > +   return adp5520_bl_set(bl, backlight_get_brightness(bl));
> > >  }
> > >
> > >  static int adp5520_bl_get_brightness(struct backlight_device *bl)
> > > diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
> > > index 19968104fc47..ddc7f5f0401f 100644
> > > --- a/drivers/video/backlight/adp8860_bl.c
> > > +++ b/drivers/video/backlight/adp8860_bl.c
> > > @@ -361,15 +361,7 @@ static int adp8860_bl_set(struct backlight_device *bl, int brightness)
> > >
> > >  static int adp8860_bl_update_status(struct backlight_device *bl)
> > >  {
> > > -   int brightness = bl->props.brightness;
> > > -
> > > -   if (bl->props.power != FB_BLANK_UNBLANK)
> > > -           brightness = 0;
> > > -
> > > -   if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> > > -           brightness = 0;
> > > -
> > > -   return adp8860_bl_set(bl, brightness);
> > > +   return adp8860_bl_set(bl, backlight_get_brightness(bl));
> > >  }
> > >
> > >  static int adp8860_bl_get_brightness(struct backlight_device *bl)
> > > diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
> > > index 4c0032010cfe..8b5213a39527 100644
> > > --- a/drivers/video/backlight/adp8870_bl.c
> > > +++ b/drivers/video/backlight/adp8870_bl.c
> > > @@ -399,15 +399,7 @@ static int adp8870_bl_set(struct backlight_device *bl, int brightness)
> > >
> > >  static int adp8870_bl_update_status(struct backlight_device *bl)
> > >  {
> > > -   int brightness = bl->props.brightness;
> > > -
> > > -   if (bl->props.power != FB_BLANK_UNBLANK)
> > > -           brightness = 0;
> > > -
> > > -   if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> > > -           brightness = 0;
> > > -
> > > -   return adp8870_bl_set(bl, brightness);
> > > +   return adp8870_bl_set(bl, backlight_get_brightness(bl));
> > >  }
> > >
> > >  static int adp8870_bl_get_brightness(struct backlight_device *bl)
> > > diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlight/bd6107.c
> > > index d5d5fb457e78..515184fbe33a 100644
> > > --- a/drivers/video/backlight/bd6107.c
> > > +++ b/drivers/video/backlight/bd6107.c
> > > @@ -82,12 +82,7 @@ static int bd6107_write(struct bd6107 *bd, u8 reg, u8 data)
> > >  static int bd6107_backlight_update_status(struct backlight_device *backlight)
> > >  {
> > >     struct bd6107 *bd = bl_get_data(backlight);
> > > -   int brightness = backlight->props.brightness;
> > > -
> > > -   if (backlight->props.power != FB_BLANK_UNBLANK ||
> > > -       backlight->props.fb_blank != FB_BLANK_UNBLANK ||
> > > -       backlight->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
> > > -           brightness = 0;
> > > +   int brightness = backlight_get_brightness(backlight);
> > >
> > >     if (brightness) {
> > >             bd6107_write(bd, BD6107_PORTSEL, BD6107_PORTSEL_LEDM(2) |
> > > diff --git a/drivers/video/backlight/corgi_lcd.c b/drivers/video/backlight/corgi_lcd.c
> > > index 25ef0cbd7583..33f5d80495e6 100644
> > > --- a/drivers/video/backlight/corgi_lcd.c
> > > +++ b/drivers/video/backlight/corgi_lcd.c
> > > @@ -420,13 +420,7 @@ static int corgi_bl_set_intensity(struct corgi_lcd *lcd, int intensity)
> > >  static int corgi_bl_update_status(struct backlight_device *bd)
> > >  {
> > >     struct corgi_lcd *lcd = bl_get_data(bd);
> > > -   int intensity = bd->props.brightness;
> > > -
> > > -   if (bd->props.power != FB_BLANK_UNBLANK)
> > > -           intensity = 0;
> > > -
> > > -   if (bd->props.fb_blank != FB_BLANK_UNBLANK)
> > > -           intensity = 0;
> > > +   int intensity = backlight_get_brightness(bd);
> > >
> > >     if (corgibl_flags & CORGIBL_SUSPENDED)
> > >             intensity = 0;
> > > diff --git a/drivers/video/backlight/da903x_bl.c b/drivers/video/backlight/da903x_bl.c
> > > index 62540e4bdedb..71f21bbc7a9f 100644
> > > --- a/drivers/video/backlight/da903x_bl.c
> > > +++ b/drivers/video/backlight/da903x_bl.c
> > > @@ -77,18 +77,7 @@ static int da903x_backlight_set(struct backlight_device *bl, int brightness)
> > >
> > >  static int da903x_backlight_update_status(struct backlight_device *bl)
> > >  {
> > > -   int brightness = bl->props.brightness;
> > > -
> > > -   if (bl->props.power != FB_BLANK_UNBLANK)
> > > -           brightness = 0;
> > > -
> > > -   if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> > > -           brightness = 0;
> > > -
> > > -   if (bl->props.state & BL_CORE_SUSPENDED)
> > > -           brightness = 0;
> > > -
> > > -   return da903x_backlight_set(bl, brightness);
> > > +   return da903x_backlight_set(bl, backlight_get_brightness(bl));
> > >  }
> > >
> > >  static int da903x_backlight_get_brightness(struct backlight_device *bl)
> > > diff --git a/drivers/video/backlight/ep93xx_bl.c b/drivers/video/backlight/ep93xx_bl.c
> > > index 4149e0b2f83c..2387009d452d 100644
> > > --- a/drivers/video/backlight/ep93xx_bl.c
> > > +++ b/drivers/video/backlight/ep93xx_bl.c
> > > @@ -36,13 +36,7 @@ static int ep93xxbl_set(struct backlight_device *bl, int brightness)
> > >
> > >  static int ep93xxbl_update_status(struct backlight_device *bl)
> > >  {
> > > -   int brightness = bl->props.brightness;
> > > -
> > > -   if (bl->props.power != FB_BLANK_UNBLANK ||
> > > -       bl->props.fb_blank != FB_BLANK_UNBLANK)
> > > -           brightness = 0;
> > > -
> > > -   return ep93xxbl_set(bl, brightness);
> > > +   return ep93xxbl_set(bl, backlight_get_brightness(bl));
> > >  }
> > >
> > >  static int ep93xxbl_get_brightness(struct backlight_device *bl)
> > > diff --git a/drivers/video/backlight/hp680_bl.c b/drivers/video/backlight/hp680_bl.c
> > > index 8ea42b8d9bc8..9123c33def05 100644
> > > --- a/drivers/video/backlight/hp680_bl.c
> > > +++ b/drivers/video/backlight/hp680_bl.c
> > > @@ -33,12 +33,8 @@ static void hp680bl_send_intensity(struct backlight_device *bd)
> > >  {
> > >     unsigned long flags;
> > >     u16 v;
> > > -   int intensity = bd->props.brightness;
> > > +   int intensity = backlight_get_brightness(bd);
> > >
> > > -   if (bd->props.power != FB_BLANK_UNBLANK)
> > > -           intensity = 0;
> > > -   if (bd->props.fb_blank != FB_BLANK_UNBLANK)
> > > -           intensity = 0;
> > >     if (hp680bl_suspended)
> > >             intensity = 0;
> > >
> > > diff --git a/drivers/video/backlight/kb3886_bl.c b/drivers/video/backlight/kb3886_bl.c
> > > index 1dfe13c18925..55794b239cff 100644
> > > --- a/drivers/video/backlight/kb3886_bl.c
> > > +++ b/drivers/video/backlight/kb3886_bl.c
> > > @@ -87,12 +87,8 @@ static const struct dmi_system_id kb3886bl_device_table[] __initconst = {
> > >
> > >  static int kb3886bl_send_intensity(struct backlight_device *bd)
> > >  {
> > > -   int intensity = bd->props.brightness;
> > > +   int intensity = backlight_get_brightness(bd);
> > >
> > > -   if (bd->props.power != FB_BLANK_UNBLANK)
> > > -           intensity = 0;
> > > -   if (bd->props.fb_blank != FB_BLANK_UNBLANK)
> > > -           intensity = 0;
> > >     if (kb3886bl_flags & KB3886BL_SUSPENDED)
> > >             intensity = 0;
> > >
> > > diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
> > > index 3f66549997c8..f54d256e2d54 100644
> > > --- a/drivers/video/backlight/led_bl.c
> > > +++ b/drivers/video/backlight/led_bl.c
> > > @@ -54,12 +54,7 @@ static void led_bl_power_off(struct led_bl_data *priv)
> > >  static int led_bl_update_status(struct backlight_device *bl)
> > >  {
> > >     struct led_bl_data *priv = bl_get_data(bl);
> > > -   int brightness = bl->props.brightness;
> > > -
> > > -   if (bl->props.power != FB_BLANK_UNBLANK ||
> > > -       bl->props.fb_blank != FB_BLANK_UNBLANK ||
> > > -       bl->props.state & BL_CORE_FBBLANK)
> > > -           brightness = 0;
> > > +   int brightness = backlight_get_brightness(bl);
> > >
> > >     if (brightness > 0)
> > >             led_bl_set_brightness(priv, brightness);
> > > diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
> > > index ee09d1bd02b9..d07a2bd805fc 100644
> > > --- a/drivers/video/backlight/lm3533_bl.c
> > > +++ b/drivers/video/backlight/lm3533_bl.c
> > > @@ -39,14 +39,8 @@ static inline int lm3533_bl_get_ctrlbank_id(struct lm3533_bl *bl)
> > >  static int lm3533_bl_update_status(struct backlight_device *bd)
> > >  {
> > >     struct lm3533_bl *bl = bl_get_data(bd);
> > > -   int brightness = bd->props.brightness;
> > >
> > > -   if (bd->props.power != FB_BLANK_UNBLANK)
> > > -           brightness = 0;
> > > -   if (bd->props.fb_blank != FB_BLANK_UNBLANK)
> > > -           brightness = 0;
> > > -
> > > -   return lm3533_ctrlbank_set_brightness(&bl->cb, (u8)brightness);
> > > +   return lm3533_ctrlbank_set_brightness(&bl->cb, backlight_get_brightness(bd));
> > >  }
> > >
> > >  static int lm3533_bl_get_brightness(struct backlight_device *bd)
> > > diff --git a/drivers/video/backlight/locomolcd.c b/drivers/video/backlight/locomolcd.c
> > > index cdc02e04f89d..297ee2e1ab0b 100644
> > > --- a/drivers/video/backlight/locomolcd.c
> > > +++ b/drivers/video/backlight/locomolcd.c
> > > @@ -111,12 +111,8 @@ static int current_intensity;
> > >
> > >  static int locomolcd_set_intensity(struct backlight_device *bd)
> > >  {
> > > -   int intensity = bd->props.brightness;
> > > +   int intensity = backlight_get_brightness(bd);
> > >
> > > -   if (bd->props.power != FB_BLANK_UNBLANK)
> > > -           intensity = 0;
> > > -   if (bd->props.fb_blank != FB_BLANK_UNBLANK)
> > > -           intensity = 0;
> > >     if (locomolcd_flags & LOCOMOLCD_SUSPENDED)
> > >             intensity = 0;
> > >
> > > diff --git a/drivers/video/backlight/lv5207lp.c b/drivers/video/backlight/lv5207lp.c
> > > index c6ad73a784e2..1842ae9a55f8 100644
> > > --- a/drivers/video/backlight/lv5207lp.c
> > > +++ b/drivers/video/backlight/lv5207lp.c
> > > @@ -46,12 +46,7 @@ static int lv5207lp_write(struct lv5207lp *lv, u8 reg, u8 data)
> > >  static int lv5207lp_backlight_update_status(struct backlight_device *backlight)
> > >  {
> > >     struct lv5207lp *lv = bl_get_data(backlight);
> > > -   int brightness = backlight->props.brightness;
> > > -
> > > -   if (backlight->props.power != FB_BLANK_UNBLANK ||
> > > -       backlight->props.fb_blank != FB_BLANK_UNBLANK ||
> > > -       backlight->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
> > > -           brightness = 0;
> > > +   int brightness = backlight_get_brightness(backlight);
> > >
> > >     if (brightness) {
> > >             lv5207lp_write(lv, LV5207LP_CTRL1,
> > > diff --git a/drivers/video/backlight/max8925_bl.c b/drivers/video/backlight/max8925_bl.c
> > > index 97cc260ff9d1..e607ec6fd4bf 100644
> > > --- a/drivers/video/backlight/max8925_bl.c
> > > +++ b/drivers/video/backlight/max8925_bl.c
> > > @@ -64,18 +64,7 @@ static int max8925_backlight_set(struct backlight_device *bl, int brightness)
> > >
> > >  static int max8925_backlight_update_status(struct backlight_device *bl)
> > >  {
> > > -   int brightness = bl->props.brightness;
> > > -
> > > -   if (bl->props.power != FB_BLANK_UNBLANK)
> > > -           brightness = 0;
> > > -
> > > -   if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> > > -           brightness = 0;
> > > -
> > > -   if (bl->props.state & BL_CORE_SUSPENDED)
> > > -           brightness = 0;
> > > -
> > > -   return max8925_backlight_set(bl, brightness);
> > > +   return max8925_backlight_set(bl, backlight_get_brightness(bl));
> > >  }
> > >
> > >  static int max8925_backlight_get_brightness(struct backlight_device *bl)
> > > diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> > > index 82b8d7594701..eff64db2e02e 100644
> > > --- a/drivers/video/backlight/pwm_bl.c
> > > +++ b/drivers/video/backlight/pwm_bl.c
> > > @@ -108,14 +108,9 @@ static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
> > >  static int pwm_backlight_update_status(struct backlight_device *bl)
> > >  {
> > >     struct pwm_bl_data *pb = bl_get_data(bl);
> > > -   int brightness = bl->props.brightness;
> > > +   int brightness = backlight_get_brightness(bl);
> > >     struct pwm_state state;
> > >
> > > -   if (bl->props.power != FB_BLANK_UNBLANK ||
> > > -       bl->props.fb_blank != FB_BLANK_UNBLANK ||
> > > -       bl->props.state & BL_CORE_FBBLANK)
> > > -           brightness = 0;
> > > -
> > >     if (pb->notify)
> > >             brightness = pb->notify(pb->dev, brightness);
> > >
> > > diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> > > index 4c8c34b99441..94d3b96244f0 100644
> > > --- a/drivers/video/backlight/qcom-wled.c
> > > +++ b/drivers/video/backlight/qcom-wled.c
> > > @@ -433,14 +433,9 @@ static int wled5_ovp_delay(struct wled *wled)
> > >  static int wled_update_status(struct backlight_device *bl)
> > >  {
> > >     struct wled *wled = bl_get_data(bl);
> > > -   u16 brightness = bl->props.brightness;
> > > +   u16 brightness = backlight_get_brightness(bl);
> > >     int rc = 0;
> > >
> > > -   if (bl->props.power != FB_BLANK_UNBLANK ||
> > > -       bl->props.fb_blank != FB_BLANK_UNBLANK ||
> > > -       bl->props.state & BL_CORE_FBBLANK)
> > > -           brightness = 0;
> > > -
> > >     mutex_lock(&wled->lock);
> > >     if (brightness) {
> > >             rc = wled->wled_set_brightness(wled, brightness);
> > > diff --git a/drivers/video/backlight/tps65217_bl.c b/drivers/video/backlight/tps65217_bl.c
> > > index 762e3feed097..8457166f357f 100644
> > > --- a/drivers/video/backlight/tps65217_bl.c
> > > +++ b/drivers/video/backlight/tps65217_bl.c
> > > @@ -77,15 +77,7 @@ static int tps65217_bl_update_status(struct backlight_device *bl)
> > >  {
> > >     struct tps65217_bl *tps65217_bl = bl_get_data(bl);
> > >     int rc;
> > > -   int brightness = bl->props.brightness;
> > > -
> > > -   if (bl->props.state & BL_CORE_SUSPENDED)
> > > -           brightness = 0;
> > > -
> > > -   if ((bl->props.power != FB_BLANK_UNBLANK) ||
> > > -           (bl->props.fb_blank != FB_BLANK_UNBLANK))
> > > -           /* framebuffer in low power mode or blanking active */
> > > -           brightness = 0;
> > > +   int brightness = backlight_get_brightness(bl);
> > >
> > >     if (brightness > 0) {
> > >             rc = tps65217_reg_write(tps65217_bl->tps,
> > > diff --git a/drivers/video/backlight/wm831x_bl.c b/drivers/video/backlight/wm831x_bl.c
> > > index e55977d54c15..c5aaee205bdf 100644
> > > --- a/drivers/video/backlight/wm831x_bl.c
> > > +++ b/drivers/video/backlight/wm831x_bl.c
> > > @@ -91,18 +91,7 @@ static int wm831x_backlight_set(struct backlight_device *bl, int brightness)
> > >
> > >  static int wm831x_backlight_update_status(struct backlight_device *bl)
> > >  {
> > > -   int brightness = bl->props.brightness;
> > > -
> > > -   if (bl->props.power != FB_BLANK_UNBLANK)
> > > -           brightness = 0;
> > > -
> > > -   if (bl->props.fb_blank != FB_BLANK_UNBLANK)
> > > -           brightness = 0;
> > > -
> > > -   if (bl->props.state & BL_CORE_SUSPENDED)
> > > -           brightness = 0;
> > > -
> > > -   return wm831x_backlight_set(bl, brightness);
> > > +   return wm831x_backlight_set(bl, backlight_get_brightness(bl));
> > >  }
> > >
> > >  static int wm831x_backlight_get_brightness(struct backlight_device *bl)
> > > --
> > > 2.25.1
> > >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

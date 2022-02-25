Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B0E4C3E63
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Feb 2022 07:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbiBYG1P (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Feb 2022 01:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiBYG1N (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Feb 2022 01:27:13 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407935AA5C
        for <linux-pwm@vger.kernel.org>; Thu, 24 Feb 2022 22:26:41 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id w63so3950983ybe.10
        for <linux-pwm@vger.kernel.org>; Thu, 24 Feb 2022 22:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i96uVXtc7Gbe59waddx08SBjdR5CvigFhdRWPMIgdY4=;
        b=Y12PIxBfKQDwbCSwXhwJHVwuCArkVHivkLlK9P6d741rbUzrnempaOmOPH3Y2DDWfo
         8qaPEKh05mJa2ZzuU8O6edTsM0K2bCqYLNcYHdfQFTlWYFvrSfgAmWDHNxI1mFiKJwNb
         1lsBtU+HunZAxaBrG4gfrxY+cFe6euQieRiCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i96uVXtc7Gbe59waddx08SBjdR5CvigFhdRWPMIgdY4=;
        b=8LE2nhKKaZvocuk3R5nhKRNL+S3hv4X7cXpjRZKxt+re5mY5Q1HqfKznKvgGVugfJX
         dwsJuj0ECCfl3fyssIcAWvf4h6wQtOUVtBfBDqTN5bu5S1i35/5NfAjgkeBvTLywC5QK
         I7GecKGqS/lmzPRp2gC0Kao8yYI/G+3zbhw6Evvp9uBGNpMwNiSoWSXUYAhMswdWIIuJ
         /AuHPgXret5Kv4CSdgA2T5NMSR/IRkShHgLAtRRwLebnXJv48fq++tY3xprOsdmTT3Ib
         X5fTs/XUDIKT3bY4R7UpTUyf/47Jtf2fKoN9pY8oDp8t4ipJPqvLF8CHW7NMrDNjyp9z
         wMfA==
X-Gm-Message-State: AOAM533bvLEVR4/VZ1v/WRqodYVWA31OLuk16xvFvfAkKBoXkq3oOO8A
        uKTWWJUlCkaDdDCgg7NX2oiC75nsSlS98vSyYOZEBg==
X-Google-Smtp-Source: ABdhPJxBJxJLBZm12OiXQxR0PDxPQgFWAe+OlfhS1iFlzOvXA/o8PHVctkEv+Wr6WPdkOXZcwSZH2ZegKV57K+2dQvc=
X-Received: by 2002:a25:d314:0:b0:624:6c1a:6f2d with SMTP id
 e20-20020a25d314000000b006246c1a6f2dmr5933837ybf.189.1645770400525; Thu, 24
 Feb 2022 22:26:40 -0800 (PST)
MIME-Version: 1.0
References: <1645003971-16908-1-git-send-email-xinlei.lee@mediatek.com>
 <1645003971-16908-5-git-send-email-xinlei.lee@mediatek.com>
 <Yhf2a/h6H1/9sN6b@robh.at.kernel.org> <acc635f9e6d4f6f278ac334b13e96ce30c8c8b1d.camel@mediatek.com>
In-Reply-To: <acc635f9e6d4f6f278ac334b13e96ce30c8c8b1d.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 25 Feb 2022 14:26:29 +0800
Message-ID: <CAGXv+5GWJOFjePKJ5ABnYP2eXeU0PM6Yo3b3vYmErUnDY4=ZQQ@mail.gmail.com>
Subject: Re: [v2,4/4] dt-bindings: pwm: Add compatible for MediaTek MT8186
To:     "xinlei.lee" <xinlei.lee@mediatek.com>
Cc:     Rob Herring <robh@kernel.org>, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        matthias.bgg@gmail.com, jitao.shi@mediatek.com,
        allen-kh.cheng@mediatek.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Feb 25, 2022 at 2:18 PM xinlei.lee <xinlei.lee@mediatek.com> wrote:
>
> On Thu, 2022-02-24 at 15:19 -0600, Rob Herring wrote:
> > On Wed, Feb 16, 2022 at 05:32:51PM +0800, xinlei.lee@mediatek.com
> > wrote:
> > > From: Xinlei Lee <xinlei.lee@mediatek.corp-partner.google.com>
> > >
> > > Add dt-binding documentation of pwm for MediaTek MT8186 SoC.
> > >
> > > Signed-off-by: Xinlei Lee <
> > > xinlei.lee@mediatek.corp-partner.google.com>
> > > ---
> > >  Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-
> > > disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-
> > > disp.yaml
> > > index 768ab04d3764..1f45b1b8c3d4 100755
> > > --- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> > > +++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
> > > @@ -17,6 +17,7 @@ properties:
> > >        - mediatek,mt6595-disp-pwm
> > >        - mediatek,mt8173-disp-pwm
> > >        - mediatek,mt8183-disp-pwm
> > > +      - mediatek,mt8186-disp-pwm
> > >        - mediatek,mt8192-disp-pwm
> > >        - mediatek,mt8195-disp-pwm
> >
> > It seems unlikely that every SoC has a different version of h/w for
> > something as simple as a PWM. There's not an appropriate fallback?
> > The
> > first version from an SoC that has all the features and would work
> > with
> > existing driver unchanged?
> >
> > Rob
>
> Hi Rob:
>
> Thanks for your suggestion,I agree with your point of view.
> If I want to show that different socs are using this disp_pwm, can I
> use oneOf with items to achieve this, and reuse the compatiable that is
> currently included in the pwm_mtk_disp.c file.
> E.g:
> - items:
>        - enum:
>            -mediatek,mt8186-disp-pwm
>        - enum:
>            -mediatek,mt8183-disp-pwm
> What's your suggestion for this program?

Using Documentation/devicetree/bindings/mmc/mtk-sd.yaml as a reference,
you would have:
  compatible:
    oneOf:
      - enum:
        - mediatek,mt6595-disp-pwm
        - mediatek,mt8173-disp-pwm
        - mediatek,mt8183-disp-pwm
      - items:
        - const: mediatek,mt8186-disp-pwm
        - const: mediatek,mt8183-disp-pwm
      ...

ChenYu


> Best Regards!
> xinlei
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

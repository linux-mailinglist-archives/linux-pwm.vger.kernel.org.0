Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37DA52CFB33
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Dec 2020 12:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgLELWR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Dec 2020 06:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbgLELVZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 5 Dec 2020 06:21:25 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F093FC061A51
        for <linux-pwm@vger.kernel.org>; Sat,  5 Dec 2020 03:19:44 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id q25so1341036oij.10
        for <linux-pwm@vger.kernel.org>; Sat, 05 Dec 2020 03:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qEju67KrzGKeNbGCR+hsKzlNc7W+7hLPgdMIlzaYx5Q=;
        b=QJl/VcveZOgUoLOm3WSF6nkfhh65hcI2ym66mwEiGEXhLL8FPhlgUfxNTYew4kWAwP
         v1pFCOUbAe5KLSCn06gQ7/7OD3f95hcdffeehWfB8QvQ3r6A8t8I36sofgspfFJ0vKdw
         tdJCK4OPQ2WzQLh9WUm+BdJJKO10afHBCyQt4e17M3Qkyytl8H3DaPnyhwmaKV8gwbx2
         6GWNxESgSnz4xN7EHnpPQuCJKujkyHOB++dXrLVLe3Axa6+iyeFFNp11tlOm8n39Qsss
         3+jFKCtGrEyHsM77zy11FZHpkIh/hqaHIphYaNmQffebhzpUoPyHcZrKJ2lOuBd9dtIQ
         2+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEju67KrzGKeNbGCR+hsKzlNc7W+7hLPgdMIlzaYx5Q=;
        b=WnU+wu7QPfZz7muZ5W+adkHJifI672/lF+/1GWWD41RnnJO14z3b8+E0/gmq/+5+w4
         Ot1oCw+Z9qT1NeHSX4vvNCx+tW2ZIy/Awf5Aej+QSrUvIC7T1Nc8mZ/2dWfH3pyhvk5K
         a6oa2uLOrVkg/P5s453nwhPmhsYTTeygUbg68N4RL2Uhsq+J5qSmBhe3CP3drogDvsUj
         ovNYVCHm8MkzYB57wU6Kuubcxuz39YY9pFoR/T9S7/eHQEMzdw+fJTIvo4WHpMXutzDz
         XuOf4lYyyYrgFGsr0ecxlJLV7e+ZJEBRGnwNX0kHlO+3EmqoeHn8PPJKMc0zcuOFBRZA
         62/A==
X-Gm-Message-State: AOAM533PHKo9WpSf0irICrJ4xrSM8z2W5f8dxxB6+L7VGBqS1cchKKBQ
        /21yP9BVGYzeTLc0nqQW0y908P9xQ4//1dNYQSu/pDjHfw==
X-Google-Smtp-Source: ABdhPJzEPoo13Paweg7H2emH4Ss+1wKz6zxC3hZJvmRTqz5MqfG8LVTU/eHR9+854KCD7GvtPLSj3qdIkptJo8c98t4=
X-Received: by 2002:aca:fd84:: with SMTP id b126mr4554417oii.85.1607167184303;
 Sat, 05 Dec 2020 03:19:44 -0800 (PST)
MIME-Version: 1.0
References: <CAHvQdo1CEQfD4gUG7gVFMqaohXAq-dZiz84VY1ZrVN6DdnRBkQ@mail.gmail.com>
 <20201204114824.u7mxu6alcsjqry5y@pengutronix.de>
In-Reply-To: <20201204114824.u7mxu6alcsjqry5y@pengutronix.de>
From:   Johannes Pointner <h4nn35.work@gmail.com>
Date:   Sat, 5 Dec 2020 12:18:25 +0100
Message-ID: <CAHvQdo0eFy9fS7nfc48Ray9J8Sf-T4dsYToL_9xXHsMCGTS_4g@mail.gmail.com>
Subject: Re: pwm: imx27: pwm-backlight strange behavior
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-imx@nxp.com
Content-Type: multipart/mixed; boundary="0000000000001da3f705b5b5c550"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

--0000000000001da3f705b5b5c550
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Uwe,

On Fri, Dec 4, 2020 at 12:48 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Johannes,
>
> On Thu, Dec 03, 2020 at 01:00:56PM +0100, Johannes Pointner wrote:
> > I just tested 5.10-rc6 with a imx6dl-board and found an issue
> > regarding the pwm-backlight.
> > Using 5.10 at about level 67 I got a new maximum and with level 68
> > it's restarting at about level 1.
> > This was working properly for me with kernel 5.4.
>
> Reverting only the last hunk helps already I assume? I starred at the
> patch for some time now and don't see a relevant change.
Yes, that's right. If I just revert the calculation in the function
pwm_imx27_apply it works again.
>
> Can you please enable PWM_DEBUG and TRACING in the kernel configuration
> and then do:
>
>         echo 1 > /sys/kernel/debug/tracing/events/pwm/enable
>
> reproduce a wrong setting (the less you do other than that the easier it
> will be to analyse the trace) and then send me the contents of
>
>         /sys/kernel/debug/tracing/trace
>
I attached the trace log. I also added a trace where I
reverted(trace_revert.log) the commit.
I did for both logs the following sequence of commands:
root# echo 1 > /sys/kernel/debug/tracing/events/pwm/enable
root# echo 0 > /sys/class/backlight/backlight/brightness
root# echo 1 > /sys/class/backlight/backlight/brightness
root# echo 50 > /sys/class/backlight/backlight/brightness
root# echo 67 > /sys/class/backlight/backlight/brightness
root# echo 68 > /sys/class/backlight/backlight/brightness

> ? Also please lookup the frequency of the per clk (grep for "pwm" in
> /sys/kernel/debug/clk/clk_summary).
root# grep pwm  /sys/kernel/debug/clk/clk_summary
                              pwm4       1        1        0
66000000          0     0  50000
Regards,
Hannes

--0000000000001da3f705b5b5c550
Content-Type: text/x-log; charset="US-ASCII"; name="trace.log"
Content-Disposition: attachment; filename="trace.log"
Content-Transfer-Encoding: base64
Content-ID: <f_kiblfwm50>
X-Attachment-Id: f_kiblfwm50

IyB0cmFjZXI6IG5vcAojCiMgZW50cmllcy1pbi1idWZmZXIvZW50cmllcy13cml0dGVuOiAyNC8y
NCAgICNQOjIKIwojICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfLS0tLS09PiBpcnFz
LW9mZgojICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8gXy0tLS09PiBuZWVkLXJlc2No
ZWQKIyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgLyBfLS0tPT4gaGFyZGlycS9zb2Z0
aXJxCiMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8fCAvIF8tLT0+IHByZWVtcHQtZGVw
dGgKIyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHx8fCAvICAgICBkZWxheQojICAgICAg
ICAgICBUQVNLLVBJRCAgICAgQ1BVIyAgfHx8fCAgIFRJTUVTVEFNUCAgRlVOQ1RJT04KIyAgICAg
ICAgICAgICAgfCB8ICAgICAgICAgfCAgIHx8fHwgICAgICB8ICAgICAgICAgfAogICAgICAgICAg
ICAgIHNoLTQ0NSAgICAgWzAwMV0gLi4uLiAgIDExNS4wODgyNzQ6IHB3bV9hcHBseTogYjg1MWNl
NTQ6IHBlcmlvZD01MDAwMDAwIGR1dHlfY3ljbGU9MCBwb2xhcml0eT0wIGVuYWJsZWQ9MAogICAg
ICAgICAgICAgIHNoLTQ0NSAgICAgWzAwMV0gLi4uLiAgIDExNS4wODgyOTk6IHB3bV9nZXQ6IGI4
NTFjZTU0OiBwZXJpb2Q9NTAwMDAwMCBkdXR5X2N5Y2xlPTAgcG9sYXJpdHk9MCBlbmFibGVkPTAK
ICAgICAgICAgICAgICBzaC00NDUgICAgIFswMDFdIC4uLi4gICAxMTUuMDg5Mzc3OiBwd21fYXBw
bHk6IGI4NTFjZTU0OiBwZXJpb2Q9NTAwMDAwMCBkdXR5X2N5Y2xlPTAgcG9sYXJpdHk9MCBlbmFi
bGVkPTAKICAgICAgICAgICAgICBzaC00NDUgICAgIFswMDFdIC4uLi4gICAxMTUuMDg5Mzk0OiBw
d21fZ2V0OiBiODUxY2U1NDogcGVyaW9kPTUwMDAwMDAgZHV0eV9jeWNsZT0wIHBvbGFyaXR5PTAg
ZW5hYmxlZD0wCiAgICAgICAgICAgICAgc2gtNDQ1ICAgICBbMDAwXSAuLi4uICAgMTE4LjE2MDcy
MTogcHdtX2FwcGx5OiBiODUxY2U1NDogcGVyaW9kPTUwMDAwMDAgZHV0eV9jeWNsZT01MDAwMCBw
b2xhcml0eT0wIGVuYWJsZWQ9MAogICAgICAgICAgICAgIHNoLTQ0NSAgICAgWzAwMF0gLi4uLiAg
IDExOC4xNjA3NDU6IHB3bV9nZXQ6IGI4NTFjZTU0OiBwZXJpb2Q9NTAwMDAwMCBkdXR5X2N5Y2xl
PTE3NTkxMCBwb2xhcml0eT0wIGVuYWJsZWQ9MAogICAgICAgICAgICAgIHNoLTQ0NSAgICAgWzAw
MF0gLi4uLiAgIDExOC4xNjE4NTQ6IHB3bV9hcHBseTogYjg1MWNlNTQ6IHBlcmlvZD01MDAwMDAw
IGR1dHlfY3ljbGU9MTc1OTEwIHBvbGFyaXR5PTAgZW5hYmxlZD0wCiAgICAgICAgICAgICAgc2gt
NDQ1ICAgICBbMDAwXSAuLi4uICAgMTE4LjE2MTg3MzogcHdtX2dldDogYjg1MWNlNTQ6IHBlcmlv
ZD01MDAwMDAwIGR1dHlfY3ljbGU9NjE5MDAwIHBvbGFyaXR5PTAgZW5hYmxlZD0wCiAgICAgICAg
ICAgICAgc2gtNDQ1ICAgICBbMDAwXSAuLi4uICAgMTE4LjQ3NzIwNTogcHdtX2FwcGx5OiBiODUx
Y2U1NDogcGVyaW9kPTUwMDAwMDAgZHV0eV9jeWNsZT01MDAwMCBwb2xhcml0eT0wIGVuYWJsZWQ9
MQogICAgICAgICAgICAgIHNoLTQ0NSAgICAgWzAwMF0gLi4uLiAgIDExOC40NzcyMjc6IHB3bV9n
ZXQ6IGI4NTFjZTU0OiBwZXJpb2Q9NTAwMDAwMCBkdXR5X2N5Y2xlPTE3NTkxMCBwb2xhcml0eT0w
IGVuYWJsZWQ9MQogICAgICAgICAgICAgIHNoLTQ0NSAgICAgWzAwMF0gLi4uLiAgIDExOC40Nzcy
ODY6IHB3bV9hcHBseTogYjg1MWNlNTQ6IHBlcmlvZD01MDAwMDAwIGR1dHlfY3ljbGU9MTc1OTEw
IHBvbGFyaXR5PTAgZW5hYmxlZD0xCiAgICAgICAgICAgICAgc2gtNDQ1ICAgICBbMDAwXSAuLi4u
ICAgMTE4LjQ3NzI5OTogcHdtX2dldDogYjg1MWNlNTQ6IHBlcmlvZD01MDAwMDAwIGR1dHlfY3lj
bGU9MTc1OTEwIHBvbGFyaXR5PTAgZW5hYmxlZD0xCiAgICAgICAgICAgICAgc2gtNDQ1ICAgICBb
MDAxXSAuLi4uICAgMTIyLjk3NTE0MzogcHdtX2FwcGx5OiBiODUxY2U1NDogcGVyaW9kPTUwMDAw
MDAgZHV0eV9jeWNsZT0yNTAwMDAwIHBvbGFyaXR5PTAgZW5hYmxlZD0xCiAgICAgICAgICAgICAg
c2gtNDQ1ICAgICBbMDAxXSAuLi4uICAgMTIyLjk3NTE2NzogcHdtX2dldDogYjg1MWNlNTQ6IHBl
cmlvZD01MDAwMDAwIGR1dHlfY3ljbGU9MjgzOTYzNyBwb2xhcml0eT0wIGVuYWJsZWQ9MQogICAg
ICAgICAgICAgIHNoLTQ0NSAgICAgWzAwMV0gLi4uLiAgIDEyMi45NzUyMjc6IHB3bV9hcHBseTog
Yjg1MWNlNTQ6IHBlcmlvZD01MDAwMDAwIGR1dHlfY3ljbGU9MjgzOTYzNyBwb2xhcml0eT0wIGVu
YWJsZWQ9MQogICAgICAgICAgICAgIHNoLTQ0NSAgICAgWzAwMV0gLi4uLiAgIDEyMi45NzUyMzk6
IHB3bV9nZXQ6IGI4NTFjZTU0OiBwZXJpb2Q9NTAwMDAwMCBkdXR5X2N5Y2xlPTI4Mzk2MzcgcG9s
YXJpdHk9MCBlbmFibGVkPTEKICAgICAgICAgICAgICBzaC00NDUgICAgIFswMDFdIC4uLi4gICAx
MzEuMDg2MjEwOiBwd21fYXBwbHk6IGI4NTFjZTU0OiBwZXJpb2Q9NTAwMDAwMCBkdXR5X2N5Y2xl
PTMzNTAwMDAgcG9sYXJpdHk9MCBlbmFibGVkPTEKICAgICAgICAgICAgICBzaC00NDUgICAgIFsw
MDFdIC4uLi4gICAxMzEuMDg2MjM0OiBwd21fZ2V0OiBiODUxY2U1NDogcGVyaW9kPTUwMDAwMDAg
ZHV0eV9jeWNsZT01ODMwNzI4IHBvbGFyaXR5PTAgZW5hYmxlZD0xCiAgICAgICAgICAgICAgc2gt
NDQ1ICAgICBbMDAxXSAuLi4uICAgMTMxLjA4NjI5MzogcHdtX2FwcGx5OiBiODUxY2U1NDogcGVy
aW9kPTUwMDAwMDAgZHV0eV9jeWNsZT01ODMwNzI4IHBvbGFyaXR5PTAgZW5hYmxlZD0xCiAgICAg
ICAgICAgICAgc2gtNDQ1ICAgICBbMDAxXSAuLi4uICAgMTMxLjA4NjMwNTogcHdtX2dldDogYjg1
MWNlNTQ6IHBlcmlvZD01MDAwMDAwIGR1dHlfY3ljbGU9NTgzMDcyOCBwb2xhcml0eT0wIGVuYWJs
ZWQ9MQogICAgICAgICAgICAgIHNoLTQ0NSAgICAgWzAwMV0gLi4uLiAgIDEzNy44NDUzMzk6IHB3
bV9hcHBseTogYjg1MWNlNTQ6IHBlcmlvZD01MDAwMDAwIGR1dHlfY3ljbGU9MzQwMDAwMCBwb2xh
cml0eT0wIGVuYWJsZWQ9MQogICAgICAgICAgICAgIHNoLTQ0NSAgICAgWzAwMV0gLi4uLiAgIDEz
Ny44NDUzNjU6IHB3bV9nZXQ6IGI4NTFjZTU0OiBwZXJpb2Q9NTAwMDAwMCBkdXR5X2N5Y2xlPTQ4
OTEwIHBvbGFyaXR5PTAgZW5hYmxlZD0xCiAgICAgICAgICAgICAgc2gtNDQ1ICAgICBbMDAxXSAu
Li4uICAgMTM3Ljg0NTM3MjogcHdtX2FwcGx5OiBiODUxY2U1NDogcGVyaW9kPTUwMDAwMDAgZHV0
eV9jeWNsZT00ODkxMCBwb2xhcml0eT0wIGVuYWJsZWQ9MQogICAgICAgICAgICAgIHNoLTQ0NSAg
ICAgWzAwMV0gLi4uLiAgIDEzNy44NDUzODI6IHB3bV9nZXQ6IGI4NTFjZTU0OiBwZXJpb2Q9NTAw
MDAwMCBkdXR5X2N5Y2xlPTQ4OTEwIHBvbGFyaXR5PTAgZW5hYmxlZD0xCg==
--0000000000001da3f705b5b5c550
Content-Type: text/x-log; charset="US-ASCII"; name="trace_revert.log"
Content-Disposition: attachment; filename="trace_revert.log"
Content-Transfer-Encoding: base64
Content-ID: <f_kiblfwmz1>
X-Attachment-Id: f_kiblfwmz1

IyB0cmFjZXI6IG5vcAojCiMgZW50cmllcy1pbi1idWZmZXIvZW50cmllcy13cml0dGVuOiAyNC8y
NCAgICNQOjIKIwojICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfLS0tLS09PiBpcnFz
LW9mZgojICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8gXy0tLS09PiBuZWVkLXJlc2No
ZWQKIyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgLyBfLS0tPT4gaGFyZGlycS9zb2Z0
aXJxCiMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8fCAvIF8tLT0+IHByZWVtcHQtZGVw
dGgKIyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHx8fCAvICAgICBkZWxheQojICAgICAg
ICAgICBUQVNLLVBJRCAgICAgQ1BVIyAgfHx8fCAgIFRJTUVTVEFNUCAgRlVOQ1RJT04KIyAgICAg
ICAgICAgICAgfCB8ICAgICAgICAgfCAgIHx8fHwgICAgICB8ICAgICAgICAgfAogICAgICAgICAg
ICAgIHNoLTQ0NCAgICAgWzAwMV0gLi4uLiAgICA1OS41MTkzNzY6IHB3bV9hcHBseTogYzU2M2I5
M2M6IHBlcmlvZD01MDAwMDAwIGR1dHlfY3ljbGU9MCBwb2xhcml0eT0wIGVuYWJsZWQ9MAogICAg
ICAgICAgICAgIHNoLTQ0NCAgICAgWzAwMV0gLi4uLiAgICA1OS41MTk0MTE6IHB3bV9nZXQ6IGM1
NjNiOTNjOiBwZXJpb2Q9NTAwMDAwMCBkdXR5X2N5Y2xlPTAgcG9sYXJpdHk9MCBlbmFibGVkPTAK
ICAgICAgICAgICAgICBzaC00NDQgICAgIFswMDFdIC4uLi4gICAgNTkuNTIwNTQ5OiBwd21fYXBw
bHk6IGM1NjNiOTNjOiBwZXJpb2Q9NTAwMDAwMCBkdXR5X2N5Y2xlPTAgcG9sYXJpdHk9MCBlbmFi
bGVkPTAKICAgICAgICAgICAgICBzaC00NDQgICAgIFswMDFdIC4uLi4gICAgNTkuNTIwNTcxOiBw
d21fZ2V0OiBjNTYzYjkzYzogcGVyaW9kPTUwMDAwMDAgZHV0eV9jeWNsZT0wIHBvbGFyaXR5PTAg
ZW5hYmxlZD0wCiAgICAgICAgICAgICAgc2gtNDQ0ICAgICBbMDAwXSAuLi4uICAgIDYzLjU1OTkw
NTogcHdtX2FwcGx5OiBjNTYzYjkzYzogcGVyaW9kPTUwMDAwMDAgZHV0eV9jeWNsZT01MDAwMCBw
b2xhcml0eT0wIGVuYWJsZWQ9MAogICAgICAgICAgICAgIHNoLTQ0NCAgICAgWzAwMF0gLi4uLiAg
ICA2My41NTk5Mjk6IHB3bV9nZXQ6IGM1NjNiOTNjOiBwZXJpb2Q9NTAwMDAwMCBkdXR5X2N5Y2xl
PTUwMDAwIHBvbGFyaXR5PTAgZW5hYmxlZD0wCiAgICAgICAgICAgICAgc2gtNDQ0ICAgICBbMDAw
XSAuLi4uICAgIDYzLjU2MDk5MDogcHdtX2FwcGx5OiBjNTYzYjkzYzogcGVyaW9kPTUwMDAwMDAg
ZHV0eV9jeWNsZT01MDAwMCBwb2xhcml0eT0wIGVuYWJsZWQ9MAogICAgICAgICAgICAgIHNoLTQ0
NCAgICAgWzAwMF0gLi4uLiAgICA2My41NjEwMDY6IHB3bV9nZXQ6IGM1NjNiOTNjOiBwZXJpb2Q9
NTAwMDAwMCBkdXR5X2N5Y2xlPTUwMDAwIHBvbGFyaXR5PTAgZW5hYmxlZD0wCiAgICAgICAgICAg
ICAgc2gtNDQ0ICAgICBbMDAwXSAuLi4uICAgIDYzLjg3ODE4OTogcHdtX2FwcGx5OiBjNTYzYjkz
YzogcGVyaW9kPTUwMDAwMDAgZHV0eV9jeWNsZT01MDAwMCBwb2xhcml0eT0wIGVuYWJsZWQ9MQog
ICAgICAgICAgICAgIHNoLTQ0NCAgICAgWzAwMF0gLi4uLiAgICA2My44NzgyMTI6IHB3bV9nZXQ6
IGM1NjNiOTNjOiBwZXJpb2Q9NTAwMDAwMCBkdXR5X2N5Y2xlPTUwMDAwIHBvbGFyaXR5PTAgZW5h
YmxlZD0xCiAgICAgICAgICAgICAgc2gtNDQ0ICAgICBbMDAwXSAuLi4uICAgIDYzLjg3ODIxOTog
cHdtX2FwcGx5OiBjNTYzYjkzYzogcGVyaW9kPTUwMDAwMDAgZHV0eV9jeWNsZT01MDAwMCBwb2xh
cml0eT0wIGVuYWJsZWQ9MQogICAgICAgICAgICAgIHNoLTQ0NCAgICAgWzAwMF0gLi4uLiAgICA2
My44NzgyMjk6IHB3bV9nZXQ6IGM1NjNiOTNjOiBwZXJpb2Q9NTAwMDAwMCBkdXR5X2N5Y2xlPTUw
MDAwIHBvbGFyaXR5PTAgZW5hYmxlZD0xCiAgICAgICAgICAgICAgc2gtNDQ0ICAgICBbMDAwXSAu
Li4uICAgIDY4LjIyMTk3MjogcHdtX2FwcGx5OiBjNTYzYjkzYzogcGVyaW9kPTUwMDAwMDAgZHV0
eV9jeWNsZT0yNTAwMDAwIHBvbGFyaXR5PTAgZW5hYmxlZD0xCiAgICAgICAgICAgICAgc2gtNDQ0
ICAgICBbMDAwXSAuLi4uICAgIDY4LjIyMTk5MTogcHdtX2dldDogYzU2M2I5M2M6IHBlcmlvZD01
MDAwMDAwIGR1dHlfY3ljbGU9MjUwMDAwMCBwb2xhcml0eT0wIGVuYWJsZWQ9MQogICAgICAgICAg
ICAgIHNoLTQ0NCAgICAgWzAwMF0gLi4uLiAgICA2OC4yMjE5OTY6IHB3bV9hcHBseTogYzU2M2I5
M2M6IHBlcmlvZD01MDAwMDAwIGR1dHlfY3ljbGU9MjUwMDAwMCBwb2xhcml0eT0wIGVuYWJsZWQ9
MQogICAgICAgICAgICAgIHNoLTQ0NCAgICAgWzAwMF0gLi4uLiAgICA2OC4yMjIwMDE6IHB3bV9n
ZXQ6IGM1NjNiOTNjOiBwZXJpb2Q9NTAwMDAwMCBkdXR5X2N5Y2xlPTI1MDAwMDAgcG9sYXJpdHk9
MCBlbmFibGVkPTEKICAgICAgICAgICAgICBzaC00NDQgICAgIFswMDFdIC4uLi4gICAgNzMuNzAx
MzI1OiBwd21fYXBwbHk6IGM1NjNiOTNjOiBwZXJpb2Q9NTAwMDAwMCBkdXR5X2N5Y2xlPTMzNTAw
MDAgcG9sYXJpdHk9MCBlbmFibGVkPTEKICAgICAgICAgICAgICBzaC00NDQgICAgIFswMDFdIC4u
Li4gICAgNzMuNzAxMzUwOiBwd21fZ2V0OiBjNTYzYjkzYzogcGVyaW9kPTUwMDAwMDAgZHV0eV9j
eWNsZT0zMzUwMDAwIHBvbGFyaXR5PTAgZW5hYmxlZD0xCiAgICAgICAgICAgICAgc2gtNDQ0ICAg
ICBbMDAxXSAuLi4uICAgIDczLjcwMTM1NzogcHdtX2FwcGx5OiBjNTYzYjkzYzogcGVyaW9kPTUw
MDAwMDAgZHV0eV9jeWNsZT0zMzUwMDAwIHBvbGFyaXR5PTAgZW5hYmxlZD0xCiAgICAgICAgICAg
ICAgc2gtNDQ0ICAgICBbMDAxXSAuLi4uICAgIDczLjcwMTM2NjogcHdtX2dldDogYzU2M2I5M2M6
IHBlcmlvZD01MDAwMDAwIGR1dHlfY3ljbGU9MzM1MDAwMCBwb2xhcml0eT0wIGVuYWJsZWQ9MQog
ICAgICAgICAgICAgIHNoLTQ0NCAgICAgWzAwMF0gLi4uLiAgICA3OC41NjQ0Njg6IHB3bV9hcHBs
eTogYzU2M2I5M2M6IHBlcmlvZD01MDAwMDAwIGR1dHlfY3ljbGU9MzQwMDAwMCBwb2xhcml0eT0w
IGVuYWJsZWQ9MQogICAgICAgICAgICAgIHNoLTQ0NCAgICAgWzAwMF0gLi4uLiAgICA3OC41NjQ0
ODM6IHB3bV9nZXQ6IGM1NjNiOTNjOiBwZXJpb2Q9NTAwMDAwMCBkdXR5X2N5Y2xlPTM0MDAwMDAg
cG9sYXJpdHk9MCBlbmFibGVkPTEKICAgICAgICAgICAgICBzaC00NDQgICAgIFswMDBdIC4uLi4g
ICAgNzguNTY0NDg3OiBwd21fYXBwbHk6IGM1NjNiOTNjOiBwZXJpb2Q9NTAwMDAwMCBkdXR5X2N5
Y2xlPTM0MDAwMDAgcG9sYXJpdHk9MCBlbmFibGVkPTEKICAgICAgICAgICAgICBzaC00NDQgICAg
IFswMDBdIC4uLi4gICAgNzguNTY0NDkzOiBwd21fZ2V0OiBjNTYzYjkzYzogcGVyaW9kPTUwMDAw
MDAgZHV0eV9jeWNsZT0zNDAwMDAwIHBvbGFyaXR5PTAgZW5hYmxlZD0xCg==
--0000000000001da3f705b5b5c550--

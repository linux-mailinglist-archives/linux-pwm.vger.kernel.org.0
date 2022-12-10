Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA1F648EB5
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Dec 2022 13:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLJMpE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 10 Dec 2022 07:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLJMpC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 10 Dec 2022 07:45:02 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D00F01A
        for <linux-pwm@vger.kernel.org>; Sat, 10 Dec 2022 04:45:02 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id s10so7684498ljg.1
        for <linux-pwm@vger.kernel.org>; Sat, 10 Dec 2022 04:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwuIivs2bXND3SDhAV+zSYDmApbibgZQPxXCRZ6VkeU=;
        b=jLV7hXRouhSyKQpvOHzWhZ+RKmpvea/2qOPhpQCxEarhtsyXW6+f11hvYAJzkERIXd
         NmlydnGZVJJcR+mWd2ug8WQdCUtC9Lxj9Tim34gVro4I/KIfSKUV+RQF0p21EilkKaoL
         E+41ivruY+rMr5mB8Yh4erj2ifwrazt92+39sQWCuoOfLMAkvwn8qMPWzryZ6X5J6pDk
         R9SEUHT9XQw2sFCuSF17rITEI1qcMKZS2lM94Zg9yAO1YruCdtu1YHGKcWxoGRgv2N2v
         RtDsncl7GTIOr0/HU0OpkjwEM184N8/+/flnGirKcutlrRYF5eK+nw65xR5wlusohi6w
         WxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwuIivs2bXND3SDhAV+zSYDmApbibgZQPxXCRZ6VkeU=;
        b=ZnHkRZ9kzpDyTrhgCO90yVoNqBFSUwDAR4FHWuLJAc7TI3cKsLt6KWXQG5IlSFqkrE
         joe5HpD2OaSSNST/uhtz2DpbZpP6pCjqQPJy2z/1YKDNG3vuJ2GdqP4TS2Vz92axLco6
         5YVxumnPUVYG9rtc/W4vD+kFugPS/IBuOztnMtQYWIZ5dKyBELeIBOU8J9ZSfoOf715N
         QVGVz0Pc0f44H0XpYbv70zNQikb5DgBhMBY72AKEpmPNQc04sGrDogkeWZaqYQyryKm6
         AGvz19OkN158nyszSUaexah8VvUnvMgZ2HvolhIrb+6oizWFC0KR0uEOni1lL0/mHkR5
         ppGg==
X-Gm-Message-State: ANoB5plnRJSDOsyoUh+YBDiTbaI8OyMBj+tSVDkmpDa8mLwwD4NnFlxq
        +TFtOlFCgsjFVv2z8eR+FrTluF7OU62wQJcRGc4=
X-Google-Smtp-Source: AA0mqf6ZeW+VTzLIVo8imE0RVjvuKUACLEmgyiK7jB8i3JwhJGyzVPuy/KorKp1c6/v43DPtebFLmukCNWp5a34sLeg=
X-Received: by 2002:a2e:a793:0:b0:27a:3e05:430d with SMTP id
 c19-20020a2ea793000000b0027a3e05430dmr248770ljf.313.1670676300160; Sat, 10
 Dec 2022 04:45:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6022:71ca:b0:32:75cc:6c4e with HTTP; Sat, 10 Dec 2022
 04:44:59 -0800 (PST)
Reply-To: canyeu298@gmail.com
From:   Can yeu <josefernandez29a@gmail.com>
Date:   Sat, 10 Dec 2022 13:44:59 +0100
Message-ID: <CA+fqxfaTtZtFJ-rgJHPw_-=_v1FPG=eogCvjL2Q94sqR1XkfLQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

-- 
Dear Friend,

I have an important message which i want to discuss with you.

Your Faithfully

Mrs Can Yeu

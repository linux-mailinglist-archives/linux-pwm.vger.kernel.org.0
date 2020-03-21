Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7E818DE3B
	for <lists+linux-pwm@lfdr.de>; Sat, 21 Mar 2020 06:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgCUF4s (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 21 Mar 2020 01:56:48 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:43804 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgCUF4s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 21 Mar 2020 01:56:48 -0400
Received: by mail-qv1-f65.google.com with SMTP id c28so4307747qvb.10;
        Fri, 20 Mar 2020 22:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gL2GEMsXemYZsa0NeenT8VlKPdt54oVv6YA/Geb5fnw=;
        b=dukvGv+XIqHXHQt9Yk0j9eS73UJGWYqaJ8tFLiTgcvcLLwGp0zblPsnnepuYHS/gb5
         q3/vZhch1WRgqTSUY9nCk/J+60SvQAdmg32AAU+H5y4peGHqeonUyISnJtodhqpGXWal
         lgL+Ht0qhZc8a/Bun39rxvKh2Eoddmi0V9WrKxB1P3ZpkIS+O1mQCtvGuCW0bEI9eisS
         r4ZEw2vq0dmnmcVCrGLKTMMGqWpRPdopXNS5S6CGbfYxXjTUlGaic3KkpH7FgOuHrcan
         GW2zv8kqxOjwMlukTdhpCbZ7rdITF8Ee3jqtHx9tEijDRUyt3mzqaoLVEASGtIjCDJEf
         yXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gL2GEMsXemYZsa0NeenT8VlKPdt54oVv6YA/Geb5fnw=;
        b=WNKW1DQiQP0KAVFkE+CUeOPoVzWANvIlHqkqGkLVnzlnAVMywi2yMZraZKrFx1uTNw
         xm9vZ1zNyrZFx//B15nfBM6/4T8Q5zOR7AZGChOp7pk+8ysXD7rJg2p0w24Yt4dYjJvZ
         5ZwwwkP6F6aqD55rZMsYa5hHGclysGcJBcqbR6W9GoKA6pAHLl33wAGpzRiPQfb16Iou
         hTsD2Vfa0r2fcZaYcVZmHVXti/aX4EKm6bJvl3vdO3mB5+iUYnJ+ppQg3+bnLm09CSzX
         /GcIkt+ZMEUj831G3YQxZPiU1HsS42cdZvgq3BMqWVheH54P61256EgHg9SXwjYoTA7I
         Wd6g==
X-Gm-Message-State: ANhLgQ1dgYt5F4Cpp6scRMohvxlwE8f2P9pP7Ze7evvQwVCwPxDrp/4O
        wz85ODKm40Z85zGDF9xRwKTF4op9fRsQFoI8xbY=
X-Google-Smtp-Source: ADFU+vtZBBSKHrJoh/ot15q6PnKl8Rv7vhzUPgeK4z50oabID5E2A9tLdVH8n2Ah02O7BA/vWhx9NqsxbOkFG3JXpEQ=
X-Received: by 2002:a0c:d601:: with SMTP id c1mr7174390qvj.164.1584770207173;
 Fri, 20 Mar 2020 22:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <1583941429-10921-1-git-send-email-gupt21@gmail.com>
 <20200311164449.flzzwxqqhcxisil3@pengutronix.de> <CALUj-guwTDR=WMz6KKADFjfFfdS3_aijfrTRCFzh9iPnFAaG6A@mail.gmail.com>
 <20200311195528.iplmlcuvp2jjaecn@pengutronix.de>
In-Reply-To: <20200311195528.iplmlcuvp2jjaecn@pengutronix.de>
From:   rishi gupta <gupt21@gmail.com>
Date:   Sat, 21 Mar 2020 11:26:35 +0530
Message-ID: <CALUj-gs4=OP3qZEyZx_VahCTXQn7gcxAkvnc7Fb6UsaRzCLOig@mail.gmail.com>
Subject: Re: [PATCH 1/1] pwm: pca9685: replace CONFIG_PM with __maybe_unused
 to prevent build issues
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, s.trumtrar@pengutronix.de,
        linux-pwm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Tested again and found one gerrit was missing in my local build.
Both __maybe_unused and CONFIG_PM are working fine.

So it is your choice to apply or not apply this patch.

Regards,
Rishi

On Thu, Mar 12, 2020 at 1:25 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Thu, Mar 12, 2020 at 01:16:28AM +0530, rishi gupta wrote:
> > These 2 links contains more details:
> > https://lore.kernel.org/patchwork/patch/732981
> > https://lkml.org/lkml/2019/1/17/437
>
> These are both about SIMPLE_DEV_PM_OPS which doesn't apply to
> pwm-pca9685.
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|

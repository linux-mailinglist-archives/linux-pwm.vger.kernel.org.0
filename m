Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB1024105
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2019 21:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbfETTTC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 May 2019 15:19:02 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36120 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfETTTC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 May 2019 15:19:02 -0400
Received: by mail-ot1-f66.google.com with SMTP id c3so14075806otr.3;
        Mon, 20 May 2019 12:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILhuswdCRnMUMBRmoi3Za/asPHf+23D/dshJBOh3X34=;
        b=IRgkt9b9zjWY7xSWKf3ivsymx+TC/KfBZhHDWrkSWQqWt6cYLLu0r0mMd+cd1BFYUz
         cK3qTiWLGAVnFU035zQqlNUcbIC17/XLJbfFmd74MeixlEr0o9e3+PtNAAqkTVN7zf2o
         LeX6rTJy6W4L/MtBXIU5piiG5DlQKQnwFsRmpq96AC3IXTiqCTT5EEmqUNMDc7ON2FY2
         tg8M4yNg4Z22Na3rD4AB3Ji5+OWe/fXvUxsy6HQ189KOgw6it7Zdiy7wFbDwJAow9sTk
         NJ/2Czl6OhEa9KaxX5Wd9IWIQaeBy2w5I/VoAChefH6yUqlSfD4Yn2pn4wNHKuo9fkDX
         WCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILhuswdCRnMUMBRmoi3Za/asPHf+23D/dshJBOh3X34=;
        b=EryjcNzR3iVXbl30T3uR+IcwcMCtCuhuFbqAiiemNDbjIEXhXZ4TSHHorz9vJxfmam
         sW+7dn2RLxNA1jTCpmRiVEJPW7tqqX2nzRGutZIpzXkaGQPiAK6YysUf1+P7ynTo/3F/
         TFQCEExbIjOJOZXlEUysexRRI4W1dV8iMiXgBChb4NDgFRRJg61SFHPglgUXhDJlaaxY
         J5PNIiH3VrcUBP2+Rno5COu6CF//BTQ5pBjAus1tY1v1CidxIszUXxZpY3pIqQCh0gpk
         voFBQgEOE53t9UfDulfkgid9q490/9DRLtT9ZcSIZyx4vB+9T1teoxNsYnGbiVvW2zwU
         Ivvw==
X-Gm-Message-State: APjAAAUjgQOoBQ2jgJcIXc7KSmH6Lh0+DeCpYZlqP71cxi1GUqHDnzpU
        4GCBqYii/WrZ4KcCfJevaJ7g9TUUYXORcjKtgzcvTpf8Or8=
X-Google-Smtp-Source: APXvYqxOKdOcy+woeXdOWs7xjYQizw+lQeSDcB2n1Zo2IaRnDlaZSguwn9t7esINb/joJB11sVjoVDP/NqKnjOr2KuM=
X-Received: by 2002:a9d:744d:: with SMTP id p13mr26102765otk.96.1558379940532;
 Mon, 20 May 2019 12:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190520140421.30074-1-narmstrong@baylibre.com>
In-Reply-To: <20190520140421.30074-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 May 2019 21:18:49 +0200
Message-ID: <CAFBinCBi_tSMMq9sUuGeTU8-KWDWczwJ=utAv4oARVTNgiDUJw@mail.gmail.com>
Subject: Re: [PATCH] pwm: pwm-meson: update with SPDX Licence identifier
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, May 20, 2019 at 4:04 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
